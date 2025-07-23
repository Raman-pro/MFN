import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_glyph_kit/flutter_glyph_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _current = 2;

  // var leds
  final glyphSlider = GlyphSlider(
    leds: [
      Phone2Led.c4,
      Phone2Led.c5,
      Phone2Led.c6,

      Phone2Led.d1_8,
      Phone2Led.d1_7,
      Phone2Led.d1_6,
      Phone2Led.d1_5,
      Phone2Led.d1_4,
      Phone2Led.d1_3,
      Phone2Led.d1_2,
      Phone2Led.d1_1,
      Phone2Led.e1,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF58A0C8),
        appBar: AppBar(
          title: const RotatedText(
            text: 'MFN-show your anger',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF113F67),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsetsGeometry.all(25)),
                    onPressed: () {
                      const duration = Duration(milliseconds: 10); // frame rate
                      const double target = 11.0;
                      const double step = 1; // smoothness

                      Timer.periodic(duration, (timer) {
                        if (_current >= target) {
                          _current = target.toInt();
                          timer.cancel();
                          return;
                        }
                        setState(() {
                          _current += step.toInt();
                        });
                        glyphSlider.slideTo(_current);
                      });
                      if (_current == 11) {
                        setState(() {
                          _current = 1;
                        });
                      }
                    },
                    child: RotatedText(text:'Show Finger'),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsetsGeometry.all(25)),
                    onPressed: () {
                      Timer.periodic(Duration(milliseconds: 30), (timer) {
                        if (_current <= 2) {
                          setState(() {
                            _current = 2;
                            glyphSlider.slideTo(_current);
                          });
                          timer.cancel();
                          return;
                        }
                        setState(() {
                          _current -= 1;
                          glyphSlider.slideTo(_current);
                        });
                        print(
                          _current,
                        ); // Replace this with setState or equivalent
                      });
                    },
                    child: RotatedText(text: 'Hide Finger'),
                  ),
                ],
              ),

              SizedBox(height: 100),

              RotatedText(text: 'Use the slider to show/hide finger🖕',),
              SizedBox(height: 30),
              // Text(data)data
              Slider(
                min: 0,
                max: (glyphSlider.leds.length - 1).toDouble(),
                divisions: glyphSlider.leds.length - 1,
                value: _current.toDouble(),
                onChanged: (v) {
                  setState(() => _current = v.toInt());
                  glyphSlider.slideTo(_current);
                },
              ),
              Text('Hold The Phone upside down.',style: TextStyle(color: Colors.black, fontSize: 24),),
              RotatedText(text: 'Like This 📱')
            ],
          ),
        ),
      ),
    );
  }
}

class RotatedText extends StatelessWidget {
  const RotatedText({
    required this.text,
    this.style=const TextStyle(color: Colors.black, fontSize: 24),
    super.key,
  });
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }
}

class GlyphSlider {
  GlyphSlider({required this.leds});

  final Phone2Glyph glyph = Phone2Glyph();
  final List<Phone2Led> leds;

  Future<void> slideTo(int step) async {
    final toLight = leds.sublist(0, step + 1);
    await glyph.toggle(channels: toLight);
  }

  Future<void> animateLoop({
    required Duration delay,
    bool reverse = false,
  }) async {
    int idx = 0, dir = 1;
    while (true) {
      await slideTo(idx);
      await Future.delayed(delay);
      idx += dir;
      if (idx == leds.length || idx < 0) {
        if (!reverse) break;
        dir = -dir;
        idx += dir * 2;
      }
    }
  }
}
