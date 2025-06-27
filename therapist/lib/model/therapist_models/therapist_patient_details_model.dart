
import 'package:dart_mappable/dart_mappable.dart';

part 'therapist_patient_details_model.mapper.dart';

// Model class to store therapist's patient details information which will be used on UI
// This class can have toEntity and fromEntity methods to convert to and from entity

@MappableClass()
class TherapistPatientDetailsModel with TherapistPatientDetailsModelMappable {
  
  @MappableField(key: 'id')
  final String patientId;

  @MappableField(key: 'patient_name')
  final String patientName;

  @MappableField(key: 'phone')
  final String phoneNo;

  @MappableField(key: 'email')
  final String email;


  TherapistPatientDetailsModel({
    required this.patientId,
    required this.patientName,
    required this.phoneNo,
    required this.email,
  });

}