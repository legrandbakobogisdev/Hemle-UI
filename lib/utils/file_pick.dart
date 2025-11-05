import 'dart:math';
import 'package:file_selector/file_selector.dart';
// ['pdf', 'doc', 'docx']
class FilePickerUtils {
  static Future<XFile?> pickFile({
    List<String>? allowedExtensions,
  }) async {
    try {
      final XTypeGroup typeGroup = XTypeGroup(
        label: 'Documents',
        extensions: allowedExtensions,
      );

      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
      return file;
    } catch (e) {
      return null;
    }
  }

  static String formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}