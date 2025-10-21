import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/paymentgateway/presentation/screens/paymentreference_screen.dart';
import 'package:hemle/features/paymentgateway/presentation/widgets/ConfirmPaymentModal.dart';

class MethodpaymentScreen extends StatefulWidget {
  const MethodpaymentScreen({super.key});

  @override
  State<MethodpaymentScreen> createState() => _MethodpaymentScreenState();
}

class _MethodpaymentScreenState extends State<MethodpaymentScreen> {
  List<Map<String, String>> methods = [
    {"id": "1", "name": "OrangeMoney", "img" : "assets/images/47.svg"},
    {"id": "2", "name": "MobileMoney", "img" : "assets/images/48.svg"},
    {"id": "3", "name": "methodspayment.banktransactions".tr(), "img" : "assets/images/49.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    label: 'methodpayment.title'.tr(),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    label: 'methodpayment.desc'.tr(),
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            
            itemCount: methods.length,
            itemBuilder: (context, index) {
              var method = methods[index];

              return GestureDetector(
                onTap: () {
                  showConfirmPaymentModal(context: context, amount: '10000', method: method['name']!, recipient: 'Maarif School', onConfirm: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => CardInformationScreen(),));
                  },);
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  height: 133.44,
                  decoration: BoxDecoration(
                    color: Color(0xFFDEEBFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFF0065FF)
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Center(
                        child: SvgPicture.asset(method['img']!),
                      ),
                
                      if(index == 2)
                      CustomText(label: method['name']!, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary,)
                    ],
                  ),
                ),
              );
          },)
        ],
      ),
    );
  }
}
