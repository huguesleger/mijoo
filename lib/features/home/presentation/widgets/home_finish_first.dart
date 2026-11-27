import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/home/presentation/bloc/home_cubit.dart';
import 'package:mijoo/features/home/presentation/home_bone_mock.dart';
import 'package:mijoo/features/home/presentation/widgets/home_finish_first_row.dart';

class HomeFinishFirst extends StatelessWidget {
  const HomeFinishFirst({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    builder: (_, HomeState state) => switch (state) {
      HomeLoading() => MjSkeletonizer(
        child: HomeFinishFirstRow(items: homeBoneMock, today: DateTime(2000)),
      ),
      HomeLoaded(:final finishFirst, :final today) =>
        finishFirst.isEmpty
            ? MjMessageView(message: t.home.nothingToFinish)
            : HomeFinishFirstRow(items: finishFirst, today: today),
      HomeFailed(:final failure) => FailureView(failure: failure),
    },
  );
}
