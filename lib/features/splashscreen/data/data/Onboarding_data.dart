import 'package:hemle/features/splashscreen/data/models/Onboarding_model.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingData {
  static final List<OnboardingModel> pages = [
    OnboardingModel(
      title: "onboarding.page1.title".tr(),
      image: "assets/images/1.png",
      imagePosition: ImagePosition.bottom,
      showActionButton: true,
    ),
    OnboardingModel(
      title: "onboarding.page2.title".tr(),
      image: "assets/images/2.png",
      imagePosition: ImagePosition.top,
      showActionButton: true,
    ),
    OnboardingModel(
      title: "onboarding.page3.title".tr(),
      image: "assets/images/3.png",
      imagePosition: ImagePosition.bottom,
      showActionButton: true,
    ),
    OnboardingModel(
      title: "onboarding.page4.title".tr(),
      description: "onboarding.page4.description".tr(),
      image: "assets/images/onboarding4.png",
      imagePosition: ImagePosition.bottom,
      showActionButton: false,
    ),
  ];
}