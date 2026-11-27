import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/scan/domain/entities/photo_source.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';
import 'package:mijoo/features/scan/domain/rules/existing_ingredient.dart';
import 'package:mijoo/features/scan/domain/scan_repository.dart';

part 'package:mijoo/features/scan/presentation/bloc/scan_state.dart';

final class ScanCubit extends SafeCubit<ScanState> {
  ScanCubit({
    required HouseholdId household,
    required PhotoSource source,
    ScanRepository? scan,
    FridgeRepository? fridge,
    Duration? minimalLoading,
  }) : _household = household,
       _source = source,
       _scan = scan ?? getIt.get<ScanRepository>(),
       _fridge = fridge ?? getIt.get<FridgeRepository>(),
       _minimalLoading = minimalLoading ?? MjLoader.minDuration,
       super(const ScanTakingPhoto());

  final HouseholdId _household;
  final PhotoSource _source;
  final ScanRepository _scan;
  final FridgeRepository _fridge;
  final Duration _minimalLoading;

  Future<void> start() {
    emit(const ScanTakingPhoto());
    return _scan
        .takePhoto(_source)
        .flatMap(
          (Option<Uint8List> photo) =>
              photo.match(() => TaskEither<AppFailure, ScanState>.right(const ScanCancelled()), _analyze),
        )
        .match<ScanState>(ScanFailed.new, identity)
        .map(emit)
        .run();
  }

  void toggle(int index) => _updateLine(index, (ScanLine line, _) => some(line.copyWith(selected: !line.selected)));

  void edit(int index, FridgeItemInput input) =>
      _updateLine(index, (ScanLine line, List<FridgeItem> items) => some(_line(input, line.confidence, items)));

  void selectAll() => switch (state) {
    final ScanReview review => emit(
      ScanReview(
        lines: <ScanLine>[
          for (final ScanLine line in review.lines) line.copyWith(selected: !review.allSelected),
        ],
        items: review.items,
        photo: review.photo,
      ),
    ),
    ScanTakingPhoto() ||
    ScanAnalyzing() ||
    ScanNothingFound() ||
    ScanSaving() ||
    ScanSaved() ||
    ScanCancelled() ||
    ScanFailed() => null,
  };

  void remove(int index) => _updateLine(index, (_, _) => none());

  Future<void> save() => switch (state) {
    final ScanReview review => _save(review.selectedLines),
    ScanTakingPhoto() ||
    ScanAnalyzing() ||
    ScanNothingFound() ||
    ScanSaving() ||
    ScanSaved() ||
    ScanCancelled() ||
    ScanFailed() => Future<void>.value(),
  };

  TaskEither<AppFailure, ScanState> _analyze(Uint8List photo) => TaskEither<AppFailure, ScanState>.Do(($) async {
    emit(ScanAnalyzing(photo));
    final List<ScanProposal> proposals = await $(
      _scan.recognizeIngredients(photo).withMinimalDelay(_minimalLoading),
    );
    final List<FridgeItem> items = await $(_currentItems());
    return proposals.isEmpty
        ? const ScanNothingFound()
        : ScanReview(
            lines: <ScanLine>[
              for (final ScanProposal proposal in proposals) _line(proposal.input, proposal.confidence, items),
            ],
            items: items,
            photo: photo,
          );
  });

  Future<void> _save(List<ScanLine> lines) {
    emit(const ScanSaving());
    return TaskEither.traverseListSeq<AppFailure, ScanLine, Unit>(lines, _write)
        .withMinimalDelay(_minimalLoading)
        .match<ScanState>(ScanFailed.new, (List<Unit> written) => ScanSaved(written.length))
        .map(emit)
        .run();
  }

  TaskEither<AppFailure, Unit> _write(ScanLine line) => line.existing.match(
    () => _fridge.addItem(_household, line.input),
    (FridgeItem item) => _fridge.updateItem(_household, item.id, mergeIntoExisting(item, line.input)),
  );

  TaskEither<AppFailure, List<FridgeItem>> _currentItems() =>
      TaskEither<AppFailure, List<FridgeItem>>(() => _fridge.watchItems(_household).first);

  ScanLine _line(FridgeItemInput input, ScanConfidence confidence, List<FridgeItem> items) => ScanLine(
    input: input,
    confidence: confidence,
    selected: true,
    existing: existingIngredient(input, items),
  );

  void _updateLine(int index, Option<ScanLine> Function(ScanLine line, List<FridgeItem> items) update) =>
      switch (state) {
        final ScanReview review => emit(
          ScanReview(
            lines: <ScanLine>[
              for (final (int position, ScanLine line) in review.lines.indexed)
                ...(position == index
                    ? update(line, review.items).match(
                        () => const <ScanLine>[],
                        (ScanLine updated) => <ScanLine>[updated],
                      )
                    : <ScanLine>[line]),
            ],
            items: review.items,
            photo: review.photo,
          ),
        ),
        ScanTakingPhoto() ||
        ScanAnalyzing() ||
        ScanNothingFound() ||
        ScanSaving() ||
        ScanSaved() ||
        ScanCancelled() ||
        ScanFailed() => null,
      };
}
