part of 'welcome_cubit.dart';

@immutable
sealed class WelcomeState {
  const WelcomeState();
}

final class WelcomeReady extends WelcomeState {
  const WelcomeReady();
}
