// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

import 'package:example/code_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final controller = ConfettiController();

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(title: const Text('🎉 Flutter Confetti🎉 ')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                _ConfettiCard(
                  confettiOptions: ConfettiOptions(
                    particleCount: 40,
                    startVelocity: 20,
                    scalar: 0.9,
                    spread: 60,
                    y: -1,
                    angle: 270,
                    ticks: 300,
                    gravity: 0.4,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                  ),
                ),
                SizedBox(height: 100),
                _ConfettiCard(
                  confettiOptions: ConfettiOptions(
                    particleCount: 40,
                    startVelocity: 20,
                    scalar: 1.5,
                    spread: 60,
                    y: -1,
                    angle: 270,
                    ticks: 300,
                    gravity: 0.4,
                    decay: 0.9,
                    wobbleSpeed: 0.001,
                  ),
                ),
                SizedBox(height: 100),
                _ConfettiCard(
                  confettiOptions: ConfettiOptions(
                    particleCount: 20,
                    startVelocity: 20,
                    spread: 120,
                    y: -1,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.4,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 0.75,
                    waveIntensity: 1,
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfettiCard extends StatefulWidget {
  const _ConfettiCard({super.key, this.confettiOptions});

  final ConfettiOptions? confettiOptions;

  @override
  State<_ConfettiCard> createState() => __ConfettiCardState();
}

class __ConfettiCardState extends State<_ConfettiCard> {
  final controller = ConfettiController();

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Цель выполнена',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  'Ваша награда',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+ 5 000 ₽',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        final timer = this.timer;

        if (timer != null) {
          timer.cancel();
          this.timer = null;
          return;
        }

        this.timer = Timer.periodic(
          Duration(milliseconds: 700),
          (timer) {
            controller.launch();
          },
        );
      },
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  // child,
                  ClipPath(
                    child: Container(
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF5C5A57).withOpacity(0.1),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Confetti(
                        controller: controller,
                        options: widget.confettiOptions,
                        child: child,
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
