import 'package:dart_mappable/dart_mappable.dart';

part 'task_model.mapper.dart';

@MappableClass()
class PatientTaskModel with PatientTaskModelMappable {
  final String title;
  final bool isCompleted;
  final DateTime date;

  const PatientTaskModel({
    required this.title,
    required this.isCompleted,
    required this.date,
  });

  static const fromMap = PatientTaskModelMapper.fromMap;
  static const fromJson = PatientTaskModelMapper.fromJson;
}
