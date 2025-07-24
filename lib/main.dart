import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_glyph_kit/flutter_glyph_kit.dart';
import 'Models/GlyphSlider.dart';
import 'Widgets/FingerButton.dart';
import 'Widgets/RotatedText.dart';

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
                  FingerButton(
                    text: 'Show Finger',
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
                  ),

                  FingerButton(
                    text: 'Close Finger',
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
                  ),
                ],
              ),

              SizedBox(height: 100),

              RotatedText(text: 'Use the slider to show/hide finger🖕',),

              SizedBox(height: 30),

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




