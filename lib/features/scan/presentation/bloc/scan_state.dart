part of 'package:mijoo/features/scan/presentation/bloc/scan_cubit.dart';

@immutable
final class ScanLine {
  const ScanLine({required this.input, required this.confidence, required this.selected, required this.existing});

  final FridgeItemInput input;
  final ScanConfidence confidence;
  final bool selected;
  final Option<FridgeItem> existing;

  ScanLine copyWith({bool? selected}) =>
      ScanLine(input: input, confidence: confidence, selected: selected ?? this.selected, existing: existing);
}

@immutable
sealed class ScanState {
  const ScanState();
}

final class ScanTakingPhoto extends ScanState {
  const ScanTakingPhoto();
}

final class ScanAnalyzing extends ScanState {
  const ScanAnalyzing(this.photo);

  final Uint8List photo;
}

final class ScanReview extends ScanState {
  const ScanReview({required this.lines, required this.items, required this.photo});

  final List<ScanLine> lines;
  final List<FridgeItem> items;
  final Uint8List photo;

  bool get allSelected => lines.every((ScanLine line) => line.selected);

  int get uncertainCount => lines.where((ScanLine line) => line.confidence == ScanConfidence.uncertain).length;

  List<ScanLine> get selectedLines => lines.where((ScanLine line) => line.selected).toList();
}

final class ScanNothingFound extends ScanState {
  const ScanNothingFound();
}

final class ScanSaving extends ScanState {
  const ScanSaving();
}

final class ScanSaved extends ScanState {
  const ScanSaved(this.count);

  final int count;
}

final class ScanCancelled extends ScanState {
  const ScanCancelled();
}

final class ScanFailed extends ScanState {
  const ScanFailed(this.failure);

  final AppFailure failure;
}
