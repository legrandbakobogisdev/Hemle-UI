import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final Function(int) onPageTap;

  const OnboardingFooter({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Indicateurs de page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              return GestureDetector(
                onTap: () => onPageTap(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
