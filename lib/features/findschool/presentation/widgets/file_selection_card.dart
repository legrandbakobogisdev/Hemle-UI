import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:hemle/utils/file_pick.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class FileSelectionCard extends StatelessWidget {
  final Document document;
  final Function(XFile, Document) onFileSelected;
  final Function(Document)? onFileRemoved;

  const FileSelectionCard({
    super.key,
    required this.document,
    required this.onFileSelected,
    this.onFileRemoved,
  });

  // Méthode pour déterminer l'icône en fonction de l'extension du fichier
  String _getFileIcon() {
    if (document.fileName != null) {
      final fileName = document.fileName!.toLowerCase();
      if (fileName.endsWith('.pdf')) {
        return 'assets/images/72.svg';
      }
    }
    return 'assets/images/71.svg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE1E4E8)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre avec style Markdown-like
            CustomText(
              label: document.title,
              fontSize: 18,
              fontWeight: document.title.startsWith('# ')
                  ? FontWeight.bold
                  : FontWeight.w600,
              color: document.title.startsWith('# ')
                  ? Colors.black
                  : Colors.grey[800],
            ),
            const SizedBox(height: 8),

            // Description
            CustomText(
              label: document.description,
              fontSize: 14,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),

            // État du fichier
            if (document.hasFile) _buildFileInfo() else _buildFileSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildFileSelector() {
    return GestureDetector(
      onTap: _selectFile,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(8),
          color: Color(0xFFE1E4E8),
        ),
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(color: Color(0xFFF7F8FA)),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset('assets/images/82.svg'),
              const SizedBox(height: 8),
              CustomText(
                label: 'selectdocuments.browsefiles'.tr(),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              const SizedBox(height: 4),
              CustomText(
                label: 'selectdocuments.Accepted formats: PDF, DOC, DOCX'.tr(),
                fontSize: 12,
                color: Color(0xFF1C2024),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileInfo() {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(8),
        color: Color(0xFFE1E4E8),
      ),
      child: Container(
        width: double.infinity,
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Color(0xFFF7F8FA)),
        child: Row(
          children: [
            // Remplacer l'icône par SvgPicture avec l'icône appropriée
            Center(
              child: SvgPicture.asset(
                _getFileIcon(),
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    label: document.fileName!,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    label: document.progressText,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  // Barre de progression si taille max définie
                  if (document.maxSize != null && document.fileSize != null)
                    _buildProgressBar(),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(IconsaxPlusLinear.trash, color: Colors.black),
              onPressed: () => onFileRemoved?.call(document),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = document.fileSize! / document.maxSize!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(
          progress < 1.0 ? Colors.orange : Colors.green,
        ),
      ),
    );
  }

  Future<void> _selectFile() async {
    final file = await FilePickerUtils.pickFile();

    if (file != null) {
      onFileSelected(file, document);
    }
  }
}