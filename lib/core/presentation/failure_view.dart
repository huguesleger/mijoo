import 'package:flutter/material.dart';

import '../../core_ui/ds_message_view.dart';
import '../domain/app_failure.dart';
import 'failure_message.dart';

class FailureView extends StatelessWidget {
  const FailureView({required this.failure, super.key});

  final AppFailure failure;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: DsMessageView(message: failureMessage(failure)),
  );
}
