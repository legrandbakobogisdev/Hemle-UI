import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hemle/components/CustomFormSection.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/auth/presentation/widgets/custom_text_field.dart';

enum MessageType { text, document, image }

class ChatMessage {
  final String content;
  final MessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.type,
    required this.timestamp,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String typedocselected = '';
  var subjetController = TextEditingController();
  var messageController = TextEditingController();

  final List<int> _selectedImagesIndexes = [];
  final List<int> _selectedDocumentsIndexes = [];

  List<ChatMessage> messages = [];

  void toggleSelectionImages(int index) {
    setState(() {
      if (_selectedImagesIndexes.contains(index)) {
        _selectedImagesIndexes.remove(index);
      } else {
        _selectedImagesIndexes.add(index);
      }
    });
  }

  void toggleSelectionDocs(int index) {
    setState(() {
      if (_selectedDocumentsIndexes.contains(index)) {
        _selectedDocumentsIndexes.remove(index);
      } else {
        _selectedDocumentsIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomBackAppbar(),
        body: Column(
          children: [_header(), _body(), _messagezone(), _footer()],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(color: AppColors.background),
      child: Row(
        children: [
          CircleAvatar(radius: 25),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(label: 'Eleanor Vance', fontWeight: FontWeight.w600),
              CustomText(
                label: 'Director',
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.backgroundSecondary),
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildMessageBubble(msg),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    switch (message.type) {
      case MessageType.text:
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(label: message.content, color: Colors.white),
                SizedBox(height: 4),
                CustomText(
                  label: DateFormat('hh:mm a').format(message.timestamp),
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        );

      case MessageType.document:
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/72.svg'),
                SizedBox(width: 8),
                CustomText(label: message.content),
              ],
            ),
          ),
        );

      case MessageType.image:
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

      }
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(color: AppColors.background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    typedocselected = typedocselected == 'imageselector' ? '' : 'imageselector';
                  });
                },
                icon: SvgPicture.asset(
                  'assets/images/71.svg',
                  color: typedocselected == 'imageselector'
                      ? AppColors.primary
                      : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    typedocselected = typedocselected == 'documentsselector' ? '' : 'documentsselector';
                  });
                },
                icon: SvgPicture.asset(
                  'assets/images/72.svg',
                  color: typedocselected == 'documentsselector'
                      ? AppColors.primary
                      : null,
                ),
              ),
            ],
          ),
          if (typedocselected != '')
            IconButton(
              onPressed: () {
                if (typedocselected == 'documentsselector') {
                  setState(() {
                    messages.add(ChatMessage(
                      content: 'birth_certificate.pdf',
                      type: MessageType.document,
                      timestamp: DateTime.now(),
                    ));
                    typedocselected = '';
                  });
                } else if (typedocselected == 'imageselector') {
                  setState(() {
                    messages.add(ChatMessage(
                      content: 'image_placeholder',
                      type: MessageType.image,
                      timestamp: DateTime.now(),
                    ));
                    typedocselected = '';
                  });
                }
              },
              icon: SvgPicture.asset('assets/images/73.svg'),
            ),
        ],
      ),
    );
  }

  Widget _messagezone() {
    if (typedocselected == 'imageselector') {
      return _buildImageSelector();
    }

    if (typedocselected == 'documentsselector') {
      return _buildDocumentSelector();
    }

    return _buildMessageInput();
  }

  Widget _buildImageSelector() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: _boxShadowed(),
      child: Column(
        children: [
          _headerSelector('global.selectimagefromgallery'.tr()),
          SizedBox(
            height: 159,
            child: ListView(
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 8,
                  spacing: 8,
                  children: List.generate(10, (index) {
                    return GestureDetector(
                      onTap: () => toggleSelectionImages(index),
                      child: Container(
                        width: 77,
                        height: 76,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: _selectedImagesIndexes.contains(index)
                                ? AppColors.primary
                                : Color(0xFFD9D9D9),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSelector() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: _boxShadowed(),
      child: Column(
        children: [
          _headerSelector('global.selectdocuments'.tr()),
          SizedBox(
            height: 159,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => toggleSelectionDocs(index),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 62,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/72.svg'),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              label: 'birth_certificate.pdf',
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              label: 'Uploaded: Sep 1, 2023',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ],
                        ),
                        Spacer(),
                        Checkbox(
                          value: _selectedDocumentsIndexes.contains(index),
                          onChanged: (_) {
                            toggleSelectionDocs(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: _boxShadowed(),
      child: Column(
        children: [
          Customformsection(
            title: 'global.subjet'.tr(),
            isRequired: false,
            input: CustomTextField(
              controller: subjetController,
              type: TextFieldType.custom,
              hintText: 'chat.writesubjet'.tr(),
              fillColor: AppColors.backgroundSecondary,
            ),
          ),
          Customformsection(
            title: 'global.message'.tr(),
            isRequired: false,
            input: CustomTextField(
              controller: messageController,
              onChanged: (value) => setState(() {}),
              type: TextFieldType.custom,
              hintText: 'chat.writemessage'.tr(),
              suffixIcon: IconButton(
                icon: Icon(Icons.send_outlined),
                color: messageController.text.isNotEmpty
                    ? AppColors.primary
                    : null,
                onPressed: () {
                  if (messageController.text.trim().isEmpty) return;
                  setState(() {
                    messages.add(ChatMessage(
                      content: messageController.text.trim(),
                      type: MessageType.text,
                      timestamp: DateTime.now(),
                    ));
                    messageController.clear();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerSelector(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label: title, fontWeight: FontWeight.w600),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              typedocselected = '';
            });
          },
        ),
      ],
    );
  }

  BoxDecoration _boxShadowed() {
    return BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.3),
          spreadRadius: 0,
          blurRadius: 6,
          offset: Offset(-2, -2),
        ),
      ],
    );
  }
}
