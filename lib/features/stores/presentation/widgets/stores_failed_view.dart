import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';

class StoresFailedView extends StatelessWidget {
  const StoresFailedView({required this.failure, super.key});

  final AppFailure failure;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      FailureView(failure: failure),
      const SizedBox(height: MjSpacing.small),
      TextButton(onPressed: context.read<StoresCubit>().search, child: Text(t.stores.retry)),
    ],
  );
}
