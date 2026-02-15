import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_group.freezed.dart';
part 'skill_group.g.dart';

@freezed
class SkillGroup with _$SkillGroup {
  const factory SkillGroup({
    @Default('') String group,
    @Default([]) List<String> items,
  }) = _SkillGroup;

  factory SkillGroup.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupFromJson(json);
}
