import 'package:flutter/foundation.dart';

import '../../../core/presentation/safe_cubit.dart';

part 'welcome_state.dart';

final class WelcomeCubit extends SafeCubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeReady());
}
