import '../widgets/confetti.dart';
import 'confetti_options.dart';

class ConfettiController {
  ConfettiController();

  ConfettiState? _confettiState;

  /// Launch the confetti.
  Future<void> launch([ConfettiOptions? options]) async {
    final state = _confettiState;
    if (state == null) {
      throw Exception('ConfettiController is unattached');
    }

    await state.launch(options);
  }

  /// Clear the confetti.
  void clear() {
    final state = _confettiState;
    if (state == null) {
      throw Exception('ConfettiController is unattached');
    }

    state.clear();
  }

  /// Attach [ConfettiState] to this [ConfettiController].
  ///
  /// Only for internal use.
  void attach(ConfettiState state) {
    if (_confettiState != null && state != _confettiState) {
      throw Exception(
        'A single ConfettiController can only be used in one widget',
      );
    }

    _confettiState = state;
  }

  /// Dettach current [ConfettiState] in this [ConfettiController].
  ///
  /// Only for internal use.
  void dettach() {
    _confettiState = null;
  }
}
