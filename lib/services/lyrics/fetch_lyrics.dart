import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:music_player/models/lyrics_model/lyrics_model.dart';

Future<LyricsModel?> fetchLyrics(
    {required String title, required String artist}) async {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://api.musixmatch.com/ws/1.1'));
  try {
    final respose = await dio.get(
        '/matcher.lyrics.get?&apikey=cd2ec6e3938df98768d4770679e74662',
        queryParameters: {"q_track": title, "q_artist": artist});
    if (respose.statusCode == 200) {
      log('data got it');
      final res = jsonDecode(respose.data);
      final result = LyricsModel.fromJson(res);
      // print(result);
      // log('${result.message?.body?.lyrics?.lyricsBody}');
      return result;
    } else {
      return null;
    }
  } catch (_) {
    return null;
  }
}
