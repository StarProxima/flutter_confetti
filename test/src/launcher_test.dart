import 'package:flutter_confetti/src/utils/launcher.dart';
import 'package:flutter_confetti/src/utils/launcher_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('callback should be called', () {
    const key = Object();
    int counter = 0;
    ConfettiLauncher.load(
        key,
        LauncherConfig(
            onLaunch: () {
              counter++;
            },
            onKill: () {}));
    ConfettiLauncher.launch(key);
    expect(counter, equals(1));
  });

  test('callback should not be called after unload', () {
    const key = Object();
    int counter = 0;

    ConfettiLauncher.load(
        key,
        LauncherConfig(
            onLaunch: () {
              counter++;
            },
            onKill: () {}));

    ConfettiLauncher.unload(key);
    ConfettiLauncher.launch(key);

    expect(counter, equals(0));
  });
}
