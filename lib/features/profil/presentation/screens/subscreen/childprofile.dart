import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_application_card.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/findschool/presentation/widgets/file_selection_card.dart';
import 'package:hemle/features/home/data/models/home_models.dart';

class Childprofile extends StatefulWidget {
  const Childprofile({super.key});

  @override
  State<Childprofile> createState() => _ChildprofileState();
}

class _ChildprofileState extends State<Childprofile> {
  final List<School> _schools = [
    School(
      id: '1',
      name: 'Starfield Academy',
      location: 'Ngaoundéré',
      type: 'Secondary',
      status: 'Accepted',
    ),
  ];

  final List<Document> documents = [
    Document(
      id: '1',
      title: 'selectdocuments.passportorid.title'.tr(),
      description: 'selectdocuments.passportorid.desc'.tr(),
    ),
    Document(
      id: '2',
      title: 'selectdocuments.passportorid.title'.tr(),
      description: 'selectdocuments.passportorid.desc'.tr(),
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
      appBar: CustomBackAppbar(),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _header(),
          Expanded(child: _body()),

          _footer(),
        ],
      ),
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
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        spacing: 8,
        children: [
          CircleAvatar(radius: 25),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                label: 'Amanda Fobi',
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                label: 'STU0001',
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: [_buildProfileSummary(), _buidocumemts(), _applications()],
    );
  }

  Widget _buildProfileSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'detailschildmodal.profilesummary'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 16),

          // Table-like information
          _buildInfoRow('global.fullname'.tr(), 'Amanda Fobi'),
          _buildInfoRow('global.age'.tr(), '7'),
          _buildInfoRow('global.dateofbirth'.tr(), '10/09/2017'),
          _buildInfoRow('global.level'.tr(), '3rd Grade'),
          _buildInfoRow('global.gender'.tr(), 'Girl'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomText(
              label: label,
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomText(
              label: value,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buidocumemts() {
    return Column(
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
      ],
    );
  }

  Widget _applications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'home.pendingapps'.tr(),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        // Liste des écoles
        ..._schools.map((school) => CustomApplicationCard(school: school)),
      ],
    );
  }

  
  Widget _footer() {
    return CustomFooter(label: 'global.applynewschool'.tr(), onPressed: (){
      
    }, fullWidth: true, isDisabled: _allDocumentsHaveFiles);
    
  }
}
