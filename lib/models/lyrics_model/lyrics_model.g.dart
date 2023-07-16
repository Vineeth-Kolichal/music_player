// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LyricsModel _$LyricsModelFromJson(Map<String, dynamic> json) => LyricsModel(
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LyricsModelToJson(LyricsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      header: json['header'] == null
          ? null
          : Header.fromJson(json['header'] as Map<String, dynamic>),
      body: json['body'] == null
          ? null
          : Body.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
    };

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      statusCode: json['status_code'] as int?,
      executeTime: (json['execute_time'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'status_code': instance.statusCode,
      'execute_time': instance.executeTime,
    };

Body _$BodyFromJson(Map<String, dynamic> json) => Body(
      lyrics: json['lyrics'] == null
          ? null
          : Lyrics.fromJson(json['lyrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'lyrics': instance.lyrics,
    };

Lyrics _$LyricsFromJson(Map<String, dynamic> json) => Lyrics(
      lyricsBody: json['lyrics_body'] as String?,
    );

Map<String, dynamic> _$LyricsToJson(Lyrics instance) => <String, dynamic>{
      'lyrics_body': instance.lyricsBody,
    };
