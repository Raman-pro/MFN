import 'package:flutter_glyph_kit/flutter_glyph_kit.dart';
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
