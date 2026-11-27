import 'package:flutter/material.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ScanFailedView extends StatelessWidget {
  const ScanFailedView({required this.failure, required this.onRetry, super.key});

  final AppFailure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      FailureView(failure: failure),
      const SizedBox(height: MjSpacing.large),
      FilledButton(onPressed: onRetry, child: Text(t.scan.retry)),
    ],
  );
}
