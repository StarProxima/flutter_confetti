import 'package:flutter_confetti/src/confetti_controller.dart';
import 'package:flutter_confetti/src/utils/launcher.dart';
import 'package:flutter_confetti/src/utils/launcher_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('callback should be called', () {
    const key = ConfettiController();
    int counter = 0;
    ConfettiLauncher.load(
        key,
        LauncherConfig(
            onLaunch: (_) async {
              counter++;
            },
            onKill: () {}));
    ConfettiLauncher.launch(key, null);
    expect(counter, equals(1));
  });

  test('callback should not be called after unload', () {
    const key = ConfettiController();
    int counter = 0;

    ConfettiLauncher.load(
        key,
        LauncherConfig(
            onLaunch: (_) async {
              counter++;
            },
            onKill: () {}));

    ConfettiLauncher.unload(key);
    ConfettiLauncher.launch(key, null);

    expect(counter, equals(0));
  });
}
