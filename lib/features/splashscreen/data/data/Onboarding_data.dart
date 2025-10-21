import 'package:hemle/features/splashscreen/data/models/Onboarding_model.dart';

class OnboardingData {
  static final List<OnboardingModel> pages = [
    OnboardingModel(
      title: "Real-time updates and effortless school management—making school life easier for every parent.",
      image: "assets/images/1.png",
      imagePosition: ImagePosition.bottom, // Image en haut
      showActionButton: true,
    ),
    OnboardingModel(
      title: "Discover the right school and apply in minutes, stay on top of grades and homework instantly and track your child's bus.", 
      image: "assets/images/2.png",
      imagePosition: ImagePosition.top, // Image en bas
      showActionButton: true,
    ),
    OnboardingModel(
      title: "Faster, simpler, and more secure than any school portal—everything parents need in one app.",
      image: "assets/images/3.png",
      imagePosition: ImagePosition.bottom, // Image en haut
      showActionButton: true,
    ),
    OnboardingModel(
      title: "Get started!",
      description: "Choose here you'd like to continue",
      image: "assets/images/onboarding4.png",
      imagePosition: ImagePosition.bottom, // Image en bas
      showActionButton: false, // Pas de bouton Next sur la dernière page
    ),
  ];
}