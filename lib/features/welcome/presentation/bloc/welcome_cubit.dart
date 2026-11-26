import 'package:flutter/foundation.dart';

import 'package:mijoo/core/core.dart';

part 'package:mijoo/features/welcome/presentation/bloc/welcome_state.dart';

final class WelcomeCubit extends SafeCubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeReady());
}
