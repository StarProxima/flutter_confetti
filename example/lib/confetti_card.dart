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

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Column(
        children: [
          Text('Title'),
          SizedBox(height: 30),
          Text('SubtitleSubtitleSubtitleSubtitleSubtitle'),
        ],
      ),
    );
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(title: const Text('🎉 Flutter Confetti🎉 ')),
        body: SingleChildScrollView(
          child: Center(
            child: GestureDetector(
              onTap: () {
                controller.launch();
              },
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 300),
                      Stack(
                        children: [
                          // child,
                          ClipPath(
                            child: Container(
                              width: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey[200],
                              ),
                              child: Confetti(
                                controller: controller,
                                options: ConfettiOptions(
                                  ticks: 9999,
                                ),
                                child: child,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 300),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
