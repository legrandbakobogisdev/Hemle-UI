import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class ReviewsScreenSchool extends StatefulWidget {
  final School school;
  const ReviewsScreenSchool({super.key, required this.school});

  @override
  State<ReviewsScreenSchool> createState() => _ReviewsScreenSchoolState();
}

class _ReviewsScreenSchoolState extends State<ReviewsScreenSchool> {
  // Tableau des reviews
  final List<Map<String, dynamic>> _reviews = [
    {
      'id': 1,
      'userName': 'Marie L.',
      'rating': 5.0,
      'comment': 'Excellent school with dedicated teachers. My daughter is thriving in this program.',
      'date': '14/12/2024',
    },
    {
      'id': 2,
      'userName': 'John D.',
      'rating': 4.5,
      'comment': 'Great facilities and caring staff. The curriculum is well-structured.',
      'date': '10/12/2024',
    },
    {
      'id': 3,
      'userName': 'Sarah K.',
      'rating': 4.0,
      'comment': 'Good school overall. Communication with parents could be improved.',
      'date': '05/12/2024',
    },
    {
      'id': 4,
      'userName': 'Paul M.',
      'rating': 5.0,
      'comment': 'Outstanding education quality. My son has improved significantly.',
      'date': '01/12/2024',
    },
    {
      'id': 5,
      'userName': 'Lisa T.',
      'rating': 3.5,
      'comment': 'Decent school but transportation services need improvement.',
      'date': '28/11/2024',
    },
  ];

  // Widget réutilisable pour les étoiles
  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isFilled = index < rating.round(); // Arrondi pour éviter les demi-étoiles
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Center(
            child: SvgPicture.asset(
              isFilled ? 'assets/images/80.svg' : 'assets/images/81.svg',
            ),
          ),
        );
      }),
    );
  }

  // Calcul de la note moyenne
  double get _averageRating {
    if (_reviews.isEmpty) return 0.0;
    final total = _reviews.fold(0.0, (sum, review) => sum + (review['rating'] as double));
    return total / _reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(), 
            const SizedBox(height: 10), 
            _reviewsList()
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label: 'schoolprofile.reviews.title'.tr(),
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),

        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          children: [
            CustomText(
              label: _averageRating.toStringAsFixed(1),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            _buildStarRating(_averageRating),
          ],
        ),
      ],
    );
  }

  Widget _reviewsList() {
    return ListView.builder(
      itemCount: _reviews.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final review = _reviews[index];
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: 150,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF7F8FA),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 20),
                  const SizedBox(width: 6),
                  CustomText(
                    label: review['userName'] as String,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),

                  const Spacer(),

                  _buildStarRating(review['rating'] as double),
                ],
              ),

              const SizedBox(height: 10),
              CustomText(
                label: review['comment'] as String,
              ),

              const Spacer(),

              CustomText(
                label: review['date'] as String, 
                color: const Color(0xFF6A737D), 
                fontSize: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}