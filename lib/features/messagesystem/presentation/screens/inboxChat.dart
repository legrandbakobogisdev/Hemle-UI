import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/messagesystem/presentation/screens/chat_screen.dart';
import 'package:hemle/features/messagesystem/presentation/screens/newchat.dart';

class Inboxchat extends StatefulWidget {
  const Inboxchat({super.key});

  @override
  State<Inboxchat> createState() => _InboxchatState();
}

class _InboxchatState extends State<Inboxchat> {
  final List<Map<String, String>> _conversations = [
    {
      "id": "1",
      "name": "Eleanor Vance",
      "last_message": "Please check your email",
      "hours": "12:35 p.m",
      "status": "notreceived",
      "number_of_unread": "1",
    },
    {
      "id": "2",
      "name": "Tatiana Gess",
      "last_message": "Thank you!",
      "hours": "8:16 a.m",
      "status": "received",
      "number_of_unread": "0",
    },
    {
      "id": "3",
      "name": "Selma Jamme",
      "last_message": "Alright. See you!",
      "hours": "15/09/2025",
      "status": "notreceived",
      "number_of_unread": "0",
    },
    {
      "id": "4",
      "name": "Fabianne Hernan",
      "last_message": "Thank you, she is very motivated!",
      "hours": "15/09/2025",
      "status": "read",
      "number_of_unread": "0",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(children: [_header(), _body()]),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label: 'global.chats'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          GestureDetector(
            child: SvgPicture.asset('assets/images/67.svg'),
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => Newchat(),));
            },
          ),
        ],
      ),
    );
  }

  Widget _body(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _conversations.length,
      itemBuilder: (context, index) {
        var conversation = _conversations[index];

        return InkWell(
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) => ChatScreen(),));
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                CircleAvatar(
                  radius: 25,
                ),
          
          
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(label: conversation['name']!, fontWeight: FontWeight.w600),
                          CustomText(label: conversation['hours']!, fontWeight: FontWeight.w400, fontSize: 12,),
                        ],
                      ),
                      
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
          
                           Row(
                            spacing: 4,
                             children: [
                              if(conversation['status']! != 'notreceived')
                                SvgPicture.asset(conversation['status'] == 'received' ? 'assets/images/68.svg' : 'assets/images/69.svg'),
                               Container(
                                constraints: BoxConstraints(maxWidth: AppSizes.screenWidth(context) / 1.6),
                                child: CustomText(label: conversation['last_message']!, fontWeight: FontWeight.w400, fontSize: 12, maxLines: 1, overflow: TextOverflow.ellipsis,)),
                             ],
                           ),
                           
                           
                           
                           if(int.parse(conversation['number_of_unread']!) > 0)
                           Container(
                             width: 18,
                             height: 18,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: AppColors.primary
                             ),
                             child: Center(child: CustomText(label: conversation['number_of_unread']!, fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.white,))),
                         ],
                       ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
