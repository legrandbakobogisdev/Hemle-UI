enum ImagePosition {
  top,
  bottom,
}

class OnboardingModel {
  final String title;
  final String? description;
  final String image;
  final ImagePosition imagePosition;
  final bool showActionButton;

  OnboardingModel({
    required this.title,
     this.description,
    required this.image,
    this.imagePosition = ImagePosition.top,
    this.showActionButton = true,
  });
}