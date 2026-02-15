import 'package:freezed_annotation/freezed_annotation.dart';

part 'offer_info.freezed.dart';
part 'offer_info.g.dart';

@freezed
class OfferInfo with _$OfferInfo {
  const factory OfferInfo({
    @Default('') String title,
    @Default('') String intro,
    @Default('') String availability,
    @Default('') String tjm,
    @Default('') String mobility,
    @Default([]) List<String> contracts,
    @Default([]) List<String> services,
  }) = _OfferInfo;

  factory OfferInfo.fromJson(Map<String, dynamic> json) =>
      _$OfferInfoFromJson(json);
}
