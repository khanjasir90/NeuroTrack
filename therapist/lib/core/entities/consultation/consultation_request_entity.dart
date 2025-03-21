import 'package:dart_mappable/dart_mappable.dart';

part 'consultation_request_entity.mapper.dart';

@MappableClass()
class ConsultationRequestEntity with ConsultationRequestEntityMappable {
  final String id;
  final String patientId;
  final String patientName;
  final String? patientProfileImageUrl;
  final String therapistId;
  final DateTime requestDate;
  final List<DateTime> proposedTimes;
  final String assessmentId;
  final String assessmentType;
  final String assessmentSummary;
  final String status;
  final DateTime? scheduledTime;
  final String? notes;
  final DateTime? lastUpdated;

  const ConsultationRequestEntity({
    required this.id,
    required this.patientId,
    required this.patientName,
    this.patientProfileImageUrl,
    required this.therapistId,
    required this.requestDate,
    required this.proposedTimes,
    required this.assessmentId,
    required this.assessmentType,
    required this.assessmentSummary,
    required this.status,
    this.scheduledTime,
    this.notes,
    this.lastUpdated,
  });

  ConsultationRequestEntity $copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? patientProfileImageUrl,
    String? therapistId,
    DateTime? requestDate,
    List<DateTime>? proposedTimes,
    String? assessmentId,
    String? assessmentType,
    String? assessmentSummary,
    String? status,
    DateTime? scheduledTime,
    String? notes,
    DateTime? lastUpdated,
  }) {
    return ConsultationRequestEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientProfileImageUrl: patientProfileImageUrl ?? this.patientProfileImageUrl,
      therapistId: therapistId ?? this.therapistId,
      requestDate: requestDate ?? this.requestDate,
      proposedTimes: proposedTimes ?? this.proposedTimes,
      assessmentId: assessmentId ?? this.assessmentId,
      assessmentType: assessmentType ?? this.assessmentType,
      assessmentSummary: assessmentSummary ?? this.assessmentSummary,
      status: status ?? this.status,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      notes: notes ?? this.notes,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
