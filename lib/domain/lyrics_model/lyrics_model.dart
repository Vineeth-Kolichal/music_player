import 'package:json_annotation/json_annotation.dart';

part 'lyrics_model.g.dart';

@JsonSerializable()
class LyricsModel {
  Message? message;

  LyricsModel({this.message});

  factory LyricsModel.fromJson(Map<String, dynamic> json) {
    return _$LyricsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsModelToJson(this);
}

@JsonSerializable()
class Message {
  Header? header;
  Body? body;

  Message({this.header, this.body});

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Header {
  @JsonKey(name: 'status_code')
  int? statusCode;
  @JsonKey(name: 'execute_time')
  double? executeTime;

  Header({this.statusCode, this.executeTime});

  factory Header.fromJson(Map<String, dynamic> json) {
    return _$HeaderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable()
class Body {
  Lyrics? lyrics;

  Body({this.lyrics});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);

  Map<String, dynamic> toJson() => _$BodyToJson(this);
}

@JsonSerializable()
class Lyrics {
  @JsonKey(name: 'lyrics_body')
  String? lyricsBody;

  Lyrics({this.lyricsBody});

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return _$LyricsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsToJson(this);
}
