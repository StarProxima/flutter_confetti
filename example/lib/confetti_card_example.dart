// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

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
                Text('flat'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 12,
                    velocity: 15,
                    scalar: 0.5,
                    angleSpread: 150,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.001,
                    flat: true,
                    launchInterval: Duration(milliseconds: 700),
                  ),
                ),
                SizedBox(height: 70),
                Text('flat + drift'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 15,
                    velocity: 15,
                    scalar: 0.5,
                    angleSpread: 150,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    driftSpread: 1,
                    flat: true,
                    launchInterval: Duration(milliseconds: 700),
                  ),
                ),
                SizedBox(height: 70),
                Text('flat + drift + wave'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 45,
                    velocity: 15,
                    scalar: 0.5,
                    angleSpread: 150,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.001,
                    waveIntensity: 0.4,
                    driftSpread: 1,
                    flat: true,
                    launchInterval: Duration(milliseconds: 2500),
                  ),
                ),
                SizedBox(height: 70),
                Text('flat + drift + wave + firework'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 40,
                    velocity: 15,
                    scalar: 0.5,
                    angleSpread: 150,
                    y: 0.25,
                    angle: 90,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.001,
                    driftSpread: 0.5,
                    waveIntensity: 0.3,
                    flat: true,
                    launchInterval: Duration(milliseconds: 2500),
                    launchDelay: Duration(milliseconds: 3000),
                  ),
                ),
                SizedBox(height: 70),
                Text('wobble'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 15,
                    velocity: 15,
                    scalar: 0.7,
                    angleSpread: 150,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    launchInterval: Duration(milliseconds: 700),
                  ),
                ),
                SizedBox(height: 70),
                Text('wobble + drift'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 15,
                    velocity: 15,
                    scalar: 0.7,
                    angleSpread: 150,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 1,
                    launchInterval: Duration(milliseconds: 700),
                  ),
                ),
                SizedBox(height: 70),
                Text('wobble + drift + wave '),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 40,
                    velocity: 15,
                    scalar: 0.7,
                    angleSpread: 150,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.2,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 1,
                    waveIntensity: 0.4,
                    launchInterval: Duration(milliseconds: 2500),
                  ),
                ),
                SizedBox(height: 70),
                Text('wobble + drift + wave + firework'),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 40,
                    velocity: 15,
                    angleSpread: 150,
                    scalar: 0.7,
                    y: 1,
                    angle: 90,
                    ticks: 500,
                    gravity: 0.25,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 1,
                    waveIntensity: 0.4,
                    launchDelay: Duration(milliseconds: 3000),
                    launchInterval: Duration(milliseconds: 2500),
                    launchPeriod: Duration(minutes: 1),
                  ),
                ),
                SizedBox(height: 70),
                Text('wobble + drift + wave + 1x firework '),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 40,
                    velocity: 15,
                    angleSpread: 150,
                    scalar: 0.7,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.25,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 1,
                    waveIntensity: 0.4,
                    launchDelay: Duration(milliseconds: 1000),
                    launchInterval: Duration(milliseconds: 2500),
                    launchPeriod: Duration(minutes: 1),
                  ),
                  onReady: (controller, options) {
                    controller.launch(
                      options.copyWith(
                        particleCount: 30,
                        y: 1,
                        angle: 90,
                        launchCount: 1,
                        launchDelay: Duration(milliseconds: 1500),
                      ),
                    );
                  },
                ),
                SizedBox(height: 70),
                Text('wobble + drift + wave + 3x firework '),
                SizedBox(height: 20),
                _ConfettiCard(
                  options: ConfettiOptions(
                    colors: colots,
                    particleCount: 40,
                    velocity: 15,
                    angleSpread: 150,
                    scalar: 0.7,
                    y: -3.5,
                    angle: 270,
                    ticks: 500,
                    gravity: 0.25,
                    decay: 0.9,
                    wobbleSpeed: 0.025,
                    driftSpread: 1,
                    waveIntensity: 0.4,
                    launchDelay: Duration(milliseconds: 2500),
                    launchInterval: Duration(milliseconds: 2500),
                    launchPeriod: Duration(minutes: 1),
                  ),
                  onReady: (controller, options) {
                    controller.launch(
                      options.copyWith(
                        particleCount: 30,
                        y: 1,
                        angle: 90,
                        launchInterval: Duration(milliseconds: 600),
                        launchDelay: Duration(milliseconds: 1500),
                        launchCount: 3,
                      ),
                    );
                  },
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
    this.options,
    this.onReady,
  });

  final ConfettiOptions? options;

  final void Function(ConfettiController controller, ConfettiOptions options)?
      onReady;

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
        controller.launch();
        widget.onReady?.call(
          controller,
          widget.options ?? ConfettiOptions(),
        );
      },
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipBehavior: Clip.none,
                    child: Container(
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF5C5A57).withOpacity(0.1),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Confetti(
                        controller: controller,
                        // onReady: () => widget.onReady?.call(
                        //     controller, widget.options ?? ConfettiOptions()),
                        particleBuilder: (_) => ParticlePainter.merge([
                          QuadrangleParticle(
                            distortionX: 1,
                            distortionY: 1,
                          ),
                          CircleParticle(),
                        ]),
                        options: widget.options,
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
