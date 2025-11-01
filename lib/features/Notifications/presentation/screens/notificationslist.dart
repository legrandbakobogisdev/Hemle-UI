import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class Notificationslist extends StatefulWidget {
  const Notificationslist({super.key});

  @override
  State<Notificationslist> createState() => _NotificationslistState();
}

class _NotificationslistState extends State<Notificationslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        children: [
          CustomHeader(title: 'Notifications'),
          _body(),
          _footer()
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: List.generate(20, (index) {
          return GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Row(
                spacing: 10,
                children: [
                  CircleAvatar(radius: 20),
      
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              label: 'Eleanor',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
      
                            CustomText(
                              label: 'now',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
      
                        CustomText(
                          label: 'Sent you a message',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  Widget _footer(){
    return CustomFooter(label: 'global.clearnotifications'.tr(), onPressed: (){}, );
  }
}
