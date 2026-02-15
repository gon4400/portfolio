import 'package:freezed_annotation/freezed_annotation.dart';

part 'hero_info.freezed.dart';
part 'hero_info.g.dart';

@freezed
class HeroInfo with _$HeroInfo {
  const factory HeroInfo({
    @Default('') String greeting,
    @Default('') String tagline,
  }) = _HeroInfo;

  factory HeroInfo.fromJson(Map<String, dynamic> json) =>
      _$HeroInfoFromJson(json);
}
