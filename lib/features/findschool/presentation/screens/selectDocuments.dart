import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/findschool/presentation/screens/childprofile_screen.dart';
import 'package:hemle/features/findschool/presentation/widgets/file_selection_card.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Selectdocuments extends StatefulWidget {
  const Selectdocuments({super.key});

  @override
  State<Selectdocuments> createState() => _SelectdocumentsState();
}

class _SelectdocumentsState extends State<Selectdocuments> {
  static const _smallSpacing = 10.0;

  final List<Document> documents = [
    Document(
      id: '1',
      title: 'selectdocuments.birthcertificate.title'.tr(),
      description: 'selectdocuments.birthcertificate.desc'.tr(),
    ),
    Document(
      id: '2',
      title: 'selectdocuments.passportorid.title'.tr(),
      description: 'selectdocuments.passportorid.desc'.tr(),
    ),
    Document(
      id: '3',
      title: 'selectdocuments.proofofaddress.title'.tr(),
      description: 'selectdocuments.proofofaddress.desc'.tr(),
    ),
    Document(
      id: '4',
      title: 'selectdocuments.recentreportcard.title',
      description: 'selectdocuments.recentreportcard.desc',
    ),
  ];

  // Getter pour vérifier si tous les documents ont un fichier
  bool get _allDocumentsHaveFiles {
    return documents.every((document) => document.hasFile);
  }

  void _onFileSelected(XFile file, Document document) async {
    final fileSize = await file.length();

    setState(() {
      final index = documents.indexWhere((doc) => doc.id == document.id);
      if (index != -1) {
        documents[index] = Document(
          id: document.id,
          title: document.title,
          description: document.description,
          fileName: file.name,
          fileSize: fileSize,
          maxSize: document.maxSize,
          file: file,
        );
      }
    });
  }

  void _onFileRemoved(Document document) {
    setState(() {
      final index = documents.indexWhere((doc) => doc.id == document.id);
      if (index != -1) {
        documents[index] = Document(
          id: document.id,
          title: document.title,
          description: document.description,
          maxSize: document.maxSize,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(children: [_header(), _body()]),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'selectdocuments.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: _smallSpacing),
          CustomText(
            label: 'selectdocuments.desc'.tr(),
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shrinkWrap: true,
        children: [
          Column(
            children: documents
                .map(
                  (document) => FileSelectionCard(
                    document: document,
                    onFileSelected: _onFileSelected,
                    onFileRemoved: _onFileRemoved,
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 20),

          CustomButton(
            onPressed: _allDocumentsHaveFiles ? () {
              
              Navigator.push(context, CupertinoPageRoute(builder: (context) => ChildprofileScreen(),));

            } : null,
            isDisabled: !_allDocumentsHaveFiles,
            icon: Icon(IconsaxPlusLinear.add, color: Colors.white),
            fullWidth: true,
            label: 'global.continue'.tr(),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}