import 'package:file_selector/file_selector.dart';
import 'package:hemle/utils/file_pick.dart';

class School {
  final String id;
  final String name;
  final String? slogan;
  final String? description;
  final String? location;
  final String? affiliation;
  final String? accreditation;
  final String? type;
  final double? amount;
  final String? image;
  final String? status;
  final String? tel;
  final String? email;
    final double? reviews;
  final String? website;

  School({
    required this.id,
    required this.name,
    this.location,
    this.type,
    this.description,
    this.accreditation,
    this.slogan,
    this.affiliation,
    this.amount,
    this.status,
    this.image,
    this.tel,
    this.reviews,
    this.email,
    this.website,
  });
}

class Homework {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isDone;

  Homework({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isDone = false,
  });
}

class Payment {
  final String id;
  final String title;
  final double amount;
  final String receiver;
  final DateTime dueDate;

  Payment({
    required this.id,
    required this.title,
    required this.amount,
    required this.receiver,
    required this.dueDate,
  });
}

class Document {
  final String id;
  final String title;
  final String description;
  final String? fileName;
  final int? fileSize;
  final int? maxSize;
  final XFile? file;

  Document({
    required this.id,
    required this.title,
    required this.description,
    this.fileName,
    this.fileSize,
    this.maxSize,
    this.file,
  });

  bool get hasFile => fileName != null && fileSize != null;
  
  String get formattedFileSize => fileSize != null 
      ? FilePickerUtils.formatFileSize(fileSize!) 
      : '';
      
  String get progressText => maxSize != null && fileSize != null
      ? '$formattedFileSize/${FilePickerUtils.formatFileSize(maxSize!)}'
      : formattedFileSize;
}