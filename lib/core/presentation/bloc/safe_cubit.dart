import 'package:flutter_bloc/flutter_bloc.dart';

/// A [Cubit] that ignores new states once it is closed.
///
/// Prevents "Cannot emit new states after calling close" when an asynchronous
/// operation completes after the screen that owns the cubit has been disposed.
class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }
}
