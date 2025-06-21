import 'package:dart_mappable/dart_mappable.dart';

import '../../../model/therapist_models/therapist_schedule_model.dart';

part 'therapist_schedule_entity.mapper.dart';

// Entity class resembling therapist's scheduled appointment information with Supabase [SESSION] table
// This class can have toModel and fromModel methods to convert to and from model

@MappableClass()
class TherapistScheduleEntity with TherapistScheduleEntityMappable {

  @MappableField(key: 'id')
  final String sessionId;

  @MappableField(key: 'created_at')
  final String createdAt;

  @MappableField(key: 'timestamp')
  final DateTime timestamp;

  @MappableField(key: 'therapist_id')
  final String therapistId;

  @MappableField(key: 'patient_id')
  final String patientId;

  @MappableField(key: 'mode')
  final int? mode;

  @MappableField(key: 'status')
  final String status;

  @MappableField(key: 'duration')
  final int? duration;

  @MappableField(key: 'name')
  final String? therapyName;

  @MappableField(key: 'patient_name')
  final String? patientName;

  @MappableField(key: 'phone')
  final String? phoneNumber;


  TherapistScheduleEntity({
    required this.sessionId,
    required this.createdAt,
    required this.timestamp,
    required this.therapistId,
    required this.patientId,
    required this.status,
    this.mode,
    this.duration,
    this.therapyName,
    this.patientName,
    this.phoneNumber,
  });

  TherapistScheduleModel toModel() {
    return TherapistScheduleModel(
      sessionId: sessionId,
      patientId: patientId,
      patientName: patientName ?? '',
      phoneNo: phoneNumber ?? '',
      therapyName: therapyName ?? '',
      timestamp: timestamp,
      mode: mode == 1 ? 'In-person' : 'Virtual',
      duration: duration,
      status: status,
    );
  }
}