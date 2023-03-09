import 'package:json_annotation/json_annotation.dart';

part 'chuck_norris.g.dart';
@JsonSerializable()
class ChuckNorris{

  final String url;
  final String id;
  final String value;

  ChuckNorris(this.url, this.id, this.value);
  factory ChuckNorris.fromJson(Map<String, dynamic> json) => _$ChuckNorrisFromJson(json);
  Map<String, dynamic> toJson() => _$ChuckNorrisToJson(this);
}