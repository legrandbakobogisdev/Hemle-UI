import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/screens/biometric_screen.dart';
import 'package:hemle/features/auth/presentation/screens/createAccount_screen.dart';
import 'package:hemle/features/auth/presentation/screens/forgotPass_screen.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';
import 'package:hemle/features/splashscreen/data/data/Onboarding_data.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/onboarding_footer.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < OnboardingData.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
        actions: [
          if (_currentPage < OnboardingData.pages.length - 1)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsetsGeometry.only(right: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(
                          OnboardingData.pages.length - 1,
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xffDEEBFF),
                          border: Border.all(color: AppColors.primary),

                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          spacing: 2,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              label: "global.skip".tr(),
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                            Icon(
                              IconsaxPlusLinear.arrow_right,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  pages(
                    CustomText(
                      label:
                          'Real-time updates and effortless school management—making school life easier for every parent.',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    Center(child: SvgPicture.asset('assets/images/1.svg')),
                  ),

                  pages(
                    Center(child: SvgPicture.asset('assets/images/2.svg')),
                    CustomText(
                      label:
                          'Discover the right school and apply in minutes, stay on top of grades and homework instantly and track your child\'s bus.',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  pages(
                    CustomText(
                      label:
                          'Faster, simpler, and more secure than any school portal—everything parents need in one app.',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    Center(child: SvgPicture.asset('assets/images/3.svg')),
                  ),

                  lastPage(),
                ],
              ),
            ),

            // Footer avec indicateurs et boutons
            OnboardingFooter(
              currentPage: _currentPage,
              totalPages: OnboardingData.pages.length,
              onNext: _nextPage,
              onPageTap: (page) {
                _pageController.jumpToPage(page);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget pages(Widget elementOne, Widget elementTwo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [elementOne, elementTwo],
      ),
    );
  }

  Widget lastPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            label: "Get Started",
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),

          SizedBox(height: 10),

          CustomText(label: "Choose how you’d like to continue", fontSize: 16, fontWeight: FontWeight.w500,),

          const SizedBox(height: 20),

          CustomButton(
            label: 'Create an Account',
            fullWidth: true,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => CreateaccountScreen()),
              );
            },
          ),

          SizedBox(height: 20),

          CustomButton(
            label: 'I have an account: Login',
            fullWidth: true,
            color: Color(0xffDEEBFF),
            textColor: AppColors.primary,
            iconalignment: IconAlignment.end,
            border: Border.all(color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => LoginaccountScreen()),
              );
            },
          ),

          SizedBox(height: 20),

          CupertinoButton(
            sizeStyle: CupertinoButtonSize.small,
            child: CustomText(
              label: 'Forget my password',
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => ForgotpassScreen()),
              );
            },
          ),

          SizedBox(height: 10),

          CupertinoButton(
            sizeStyle: CupertinoButtonSize.small,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                CustomText(
                  label: 'Continue as Guest',
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Icon(IconsaxPlusLinear.arrow_right, color: AppColors.primary),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => BiometricScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
