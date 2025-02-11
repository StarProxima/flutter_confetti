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
    final colots = [
      Color(0xFF4060E3),
      Color(0xFFFA3E2C),
      Color(0xFF2041B0),
      Color(0xFFFCB900),
      Color(0xFF00CA50),
      Color(0xFFC81EFA),
      Color(0xFF4060E3).withOpacity(0.6),
      Color(0xFFFA3E2C).withOpacity(0.6),
      Color(0xFF2041B0).withOpacity(0.6),
      Color(0xFFFCB900).withOpacity(0.6),
      Color(0xFF00CA50).withOpacity(0.6),
      Color(0xFFC81EFA).withOpacity(0.6),
    ];
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        // appBar: AppBar(title: const Text('')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 70),
                // Text('flat'),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 12,
                //     startVelocity: 20,
                //     scalar: 0.5,
                //     spread: 150,
                //     y: -1,
                //     angle: 270,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     wobbleSpeed: 0.001,
                //     flat: true,
                //   ),
                // ),
                // SizedBox(height: 70),
                // Text('flat + drift'),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 15,
                //     startVelocity: 20,
                //     scalar: 0.5,
                //     spread: 150,
                //     y: -1,
                //     angle: 270,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     driftSpread: 1,
                //     flat: true,
                //   ),
                // ),
                // SizedBox(height: 70),
                // Text('flat + drift + wave'),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   duration: Duration(milliseconds: 2500),
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 45,
                //     startVelocity: 20,
                //     scalar: 0.5,
                //     spread: 150,
                //     y: -1,
                //     angle: 270,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     wobbleSpeed: 0.001,
                //     waveIntensity: 0.4,
                //     driftSpread: 1,
                //     flat: true,
                //   ),
                // ),
                // SizedBox(height: 70),
                // Text('flat + drift + wave + firework'),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   duration: Duration(milliseconds: 2500),
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 40,
                //     startVelocity: 18,
                //     scalar: 0.5,
                //     spread: 150,
                //     y: 0.25,
                //     angle: 90,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     wobbleSpeed: 0.001,
                //     driftSpread: 0.5,
                //     waveIntensity: 0.3,
                //     flat: true,
                //   ),
                // ),
                // SizedBox(height: 70),
                // Text('wobble'),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 15,
                //     startVelocity: 20,
                //     scalar: 0.7,
                //     spread: 150,
                //     y: -1,
                //     angle: 270,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     wobbleSpeed: 0.025,
                //   ),
                // ),
                // SizedBox(height: 70),
                // Text('wobble + drift'),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 15,
                //     startVelocity: 20,
                //     scalar: 0.7,
                //     spread: 150,
                //     y: -1,
                //     angle: 270,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     wobbleSpeed: 0.025,
                //     driftSpread: 1,
                //   ),
                // ),
                // SizedBox(height: 70),
                // Text('wobble + drift + wave '),
                // SizedBox(height: 20),
                // _ConfettiCard(
                //   duration: Duration(milliseconds: 2500),
                //   confettiOptions: ConfettiOptions(
                //     colors: colots,
                //     particleCount: 40,
                //     startVelocity: 15,
                //     scalar: 0.7,
                //     spread: 150,
                //     y: -1,
                //     angle: 270,
                //     ticks: 800,
                //     gravity: 0.2,
                //     decay: 0.9,
                //     wobbleSpeed: 0.025,
                //     driftSpread: 1,
                //     waveIntensity: 0.4,
                //   ),
                // ),
                // SizedBox(height: 70),
                Text('wobble + drift + wave + firework'),
                SizedBox(height: 20),
                _ConfettiCard(
                  duration: Duration(milliseconds: 2500),
                  confettiOptions: ConfettiOptions(
                    colors: colots,
                    particleCount: 40,
                    startVelocity: 15,
                    spread: 150,
                    scalar: 0.7,
                    y: -0.75,
                    angle: 270,
                    ticks: 800,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 1,
                    waveIntensity: 0.4,
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
  const _ConfettiCard({
    super.key,
    this.confettiOptions,
    this.duration,
    this.onActive,
  });

  final ConfettiOptions? confettiOptions;

  final VoidCallback? onActive;

  final Duration? duration;

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
          widget.duration ?? Duration(milliseconds: 700),
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
                        repeatInterval:
                            widget.duration ?? Duration(milliseconds: 700),
                        onActive: () async {
                          Future<void> salute() async {
                            await Future.delayed(Duration(milliseconds: 500));
                            controller.launch(
                              widget.confettiOptions?.copyWith(
                                particleCount: 30,
                                y: 0.25,
                                // x: 0.25,
                                angle: 90,
                              ),
                            );
                            await Future.delayed(Duration(milliseconds: 500));
                            controller.launch(
                              widget.confettiOptions?.copyWith(
                                particleCount: 30,
                                y: 0.25,
                                // x: 0.5,
                                angle: 90,
                              ),
                            );
                            await Future.delayed(Duration(milliseconds: 500));
                            controller.launch(
                              widget.confettiOptions?.copyWith(
                                particleCount: 30,
                                y: 0.25,
                                // x: 0.75,
                                angle: 90,
                              ),
                            );
                          }

                          await salute();
                        },
                        particleBuilder: (_) => ConfettiParticle.merge([
                          Quadrangle(
                            distortionX: 1,
                            distortionY: 1,
                          ),
                        ]),
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
