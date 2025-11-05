import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_title_desc.dart';
import 'package:hemle/config/colors/appColors.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        children: [
          CustomHeader(title: 'FAQ'),

          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                CustomTitleDesc(
                  title: 'What can I see in the app?',
                  fontsize: 16,
                  desc:
                      'You can view your child’s grades, attendance, homework, schedule, announcements, and teacher comments in real time.',
                ),
                SizedBox(height: 10,),
                CustomTitleDesc(
                  title: 'Can I see information for more than one child?',
                  fontsize: 16,
                  desc:
                      'Yes. If you have multiple children enrolled, you can switch between their profiles.',
                ),
                 SizedBox(height: 10,),
                CustomTitleDesc(
                  title: 'How often is the information updated?',
                  fontsize: 16,
                  desc:
                      'Grades, attendance, and homework are updated daily by the teachers or school administration.',
                ),
                 SizedBox(height: 10,),
                CustomTitleDesc(
                  title: 'Can I communicate with teachers through the app?',
                  fontsize: 16,
                  desc:
                      'Yes. The app includes a secure messaging feature where you can send and receive messages from teachers.',
                ),
                 SizedBox(height: 10,),
                CustomTitleDesc(
                  title: 'What if I forget my login details?',
                  fontsize: 16,
                  desc:
                      'You can reset your password using the “Forgot Password” option on the login screen or contact school administration for assistance.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
