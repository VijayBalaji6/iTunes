import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootDetectionProvider = FutureProvider<bool>((ref) async {
  try {
    bool jailBroken = await FlutterJailbreakDetection.jailbroken;
    bool rooted = await FlutterJailbreakDetection.developerMode;

    return jailBroken || rooted;
  } catch (e) {
    return false;
  }
});
