import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';
import 'package:mijoo/features/scan/domain/entities/scan_proposal.dart';

const int maxProposalNameLength = 80;

Option<List<ScanProposal>> geminiToScanProposals(String json) => _decode(json)
    .flatMap(
      (Map<String, Object?> data) => switch (data['ingredients']) {
        final List<Object?> ingredients => some(ingredients),
        _ => none<List<Object?>>(),
      },
    )
    .map(
      (List<Object?> ingredients) => <ScanProposal>[
        for (final Object? ingredient in ingredients)
          if (ingredient case final Map<String, Object?> data)
            if (_geminiToScanProposal(data).toNullable() case final ScanProposal proposal) proposal,
      ],
    );

Option<DateTime> geminiToBestBefore(String json) => _decode(json)
    .flatMap(
      (Map<String, Object?> data) => switch (data['bestBefore']) {
        final String date => Option<DateTime>.fromNullable(DateTime.tryParse(date)),
        _ => none<DateTime>(),
      },
    )
    .filter((DateTime date) => date.year >= 2000 && date.year <= 2100)
    .map((DateTime date) => DateTime(date.year, date.month, date.day));

Option<ScanProposal> _geminiToScanProposal(Map<String, Object?> data) => switch (data['name']) {
  final String name when name.trim().isNotEmpty => some(
    ScanProposal(
      name: _shorten(name.trim()),
      quantity: switch (data['quantity']) {
        final num quantity => some(quantity.toDouble()),
        _ => none<double>(),
      }.filter((double quantity) => quantity > 0 && quantity <= maxFridgeQuantity).getOrElse(() => 1),
      unit: _byName(FridgeUnit.values, data['unit']).getOrElse(() => FridgeUnit.piece),
      category: _byName(FridgeCategory.values, data['category']).getOrElse(() => FridgeCategory.other),
      confidence: _byName(ScanConfidence.values, data['confidence']).getOrElse(() => ScanConfidence.uncertain),
    ),
  ),
  _ => none(),
};

String _shorten(String name) =>
    name.length > maxProposalNameLength ? name.substring(0, maxProposalNameLength).trim() : name;

Option<Map<String, Object?>> _decode(String json) => Option<Object?>.tryCatch(() => jsonDecode(json)).flatMap(
  (Object? data) => switch (data) {
    final Map<String, Object?> map => some(map),
    _ => none(),
  },
);

Option<T> _byName<T extends Enum>(List<T> values, Object? name) =>
    Option<T>.fromNullable(values.where((T value) => value.name == name).firstOrNull);
