import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String title,
    @Default('') String shortDescription,
    @Default('') String description,
    @Default('') String role,
    @Default([]) List<String> tags,
    @Default('assets/icon/app_icon.png') String imageAsset,
    @Default('') String animation,
    @Default([]) List<String> gallery,
    String? storeLink,
    String? repoLink,
    @Default('') String link,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
