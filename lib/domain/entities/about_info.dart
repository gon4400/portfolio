import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_info.freezed.dart';
part 'about_info.g.dart';

@freezed
class AboutInfo with _$AboutInfo {
  const factory AboutInfo({
    @Default('') String name,
    @Default('') String initials,
    @Default('') String photo,
    @Default('') String experience,
    @Default('') String location,
    @Default('') String stack,
    @Default('') String paragraph,
  }) = _AboutInfo;

  factory AboutInfo.fromJson(Map<String, dynamic> json) =>
      _$AboutInfoFromJson(json);
}