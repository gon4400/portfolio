import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:portfolio/domain/entities/about_info.dart';
import 'package:portfolio/domain/entities/contact_info.dart';
import 'package:portfolio/domain/entities/hero_info.dart';
import 'package:portfolio/domain/entities/offer_info.dart';
import 'package:portfolio/domain/entities/project.dart';
import 'package:portfolio/domain/entities/skill_group.dart';

part 'portfolio_data.freezed.dart';
part 'portfolio_data.g.dart';

@freezed
class PortfolioData with _$PortfolioData {
  const factory PortfolioData({
    @Default(HeroInfo()) HeroInfo hero,
    @Default(AboutInfo()) AboutInfo about,
    @Default(ContactInfo()) ContactInfo contact,
    @Default([]) List<SkillGroup> skills,
    @Default(OfferInfo()) OfferInfo offers,
    @Default([]) List<Project> projects,
  }) = _PortfolioData;

  factory PortfolioData.fromJson(Map<String, dynamic> json) =>
      _$PortfolioDataFromJson(json);
}
