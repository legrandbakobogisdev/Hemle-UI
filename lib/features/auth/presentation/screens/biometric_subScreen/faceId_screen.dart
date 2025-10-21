import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/screens/loginAccount_screen.dart';

class FaceidScreen extends StatefulWidget {
  const FaceidScreen({super.key});

  @override
  State<FaceidScreen> createState() => _FaceidScreenState();
}

class _FaceidScreenState extends State<FaceidScreen> {
  String status = 'nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: status == 'fail' ? Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/9.png'),
            CupertinoButton(
              sizeStyle: CupertinoButtonSize.small,
              child: CustomText(
                label: 'global.usepass'.tr(),
                fontSize: 16,
                color: AppColors.primary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginaccountScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ) : null,
      body: Container(
        width: double.infinity,
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              label: status == 'fail'
                  ? 'Oops!'
                  : 'auth.biometric.faceid.title'.tr(),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),

            SizedBox(height: 10),

            CustomText(
              label: status == 'fail'
                  ? 'auth.biometric.faceid.fail'.tr()
                  : 'auth.biometric.faceid.desc'.tr(),
              fontSize: 16,
              textAlign: TextAlign.center,
            ),

            if (status == 'nothing')
              InkWell(
                onTap: () {
                  setState(() {
                    status = 'success';
                  });
                },
                child: SizedBox(height: 200, width: double.infinity),
              ),

            if (status == 'success')
              GestureDetector(
                onTap: () {
                  setState(() {
                    status = 'fail';
                  });
                },
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      "assets/images/4.png",
                      width: 86,
                      height: 86,
                    ),
                  ),
                ),
              ),

            if (status == 'fail')
              GestureDetector(
                onTap: () {
                  setState(() {
                    status = 'fail';
                  });
                },
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      "assets/images/6.png",
                      width: 86,
                      height: 86,
                    ),
                  ),
                ),
              ),

            if (status == 'fail')
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/10.png'),
                    CupertinoButton(
                      sizeStyle: CupertinoButtonSize.small,
                      child: CustomText(
                        label: 'global.tryagain'.tr(),
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

            if (status == 'nothing')
              CustomText(
                label: 'auth.biometric.faceid.scanning'.tr(),
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
