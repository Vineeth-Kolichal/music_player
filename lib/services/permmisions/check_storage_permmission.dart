import 'package:on_audio_query/on_audio_query.dart';

class CheckPermmission {
  static Future<bool> checkAndRequestPermissions({bool retry = false}) async {
    OnAudioQuery audioQuery = OnAudioQuery();
    bool hasPermission = false;
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    return hasPermission;
  }
}
