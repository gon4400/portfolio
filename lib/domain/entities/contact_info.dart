import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_info.freezed.dart';
part 'contact_info.g.dart';

@freezed
class ContactInfo with _$ContactInfo {
  const factory ContactInfo({
    @Default('') String email,
    @Default('') String github,
    @Default('') String linkedin,
    @Default('') String calendly,
    @Default('') String cvShortUrl,
    @Default('') String cvFullUrl,
  }) = _ContactInfo;

  factory ContactInfo.fromJson(Map<String, dynamic> json) =>
      _$ContactInfoFromJson(json);
}
