import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_contact_widget.dart';
import 'package:hemle/components/custom_header.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';

class Newchat extends StatefulWidget {
  const Newchat({super.key});

  @override
  State<Newchat> createState() => _NewchatState();
}

class _NewchatState extends State<Newchat> {
  final TextEditingController _contactController = TextEditingController();

  final List<Map<String, String>> _contacts = [
    {"id": "1", "name": "Eleanor Vance", "work": "Director"},
    {"id": "2", "name": "Tatiana Gess", "work": "Teacher of maths"},
    {"id": "3", "name": "Selma Jamme", "work": "Teacher of science "},
  ];

   List<Map<String, String>> filteredContacts = [];

  void _filterContacts(String query){
    filteredContacts = _contacts.where((contact){
      return contact['name']!.toLowerCase().contains(query.toLowerCase()) || contact['work']!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        children: [
          CustomHeader(
            title: 'global.newchat'.tr(),
            hideshadow: true,
            actions: Column(
              children: [
                CustomTextField(
                  controller: _contactController,
                  prefixIcon: Icon(Icons.search),
                  type: TextFieldType.custom,
                  hintText: 'newchat.hint'.tr(),
                  onChanged: (value) => _filterContacts(value),
                ),
              ],
            ),
          ),

          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: _contactController.text.isEmpty
          ? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: 'newchat.frequendlycontacted'.tr(),
                      fontWeight: FontWeight.w600,
                    ),

                    ..._contacts.map(
                      (contact) => CustomContactWidget(
                        name: contact['name']!,
                        work: contact['work']!,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: 'newchat.allcontacts'.tr(),
                      fontWeight: FontWeight.w600,
                    ),

                    ..._contacts.map(
                      (contact) => CustomContactWidget(
                        name: contact['name']!,
                        work: contact['work']!,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : 
          ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...filteredContacts.map(
                      (contact) => CustomContactWidget(
                        name: contact['name']!,
                        work: contact['work']!,
                      ),
                    ),
                  ],
                ),

              ],
            )
          ,
    );
  }
}
