import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/presentation/failure_message.dart';

class FailureView extends StatelessWidget {
  const FailureView({required this.failure, super.key});

  final AppFailure failure;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: DsMessageView(message: failureMessage(failure)),
  );
}
