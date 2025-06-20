import 'package:patient/core/result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/entities/entities.dart';
import '../core/repository/repository.dart';
import '../model/therapy_models/therapy_models.dart';

class SupabasePatientRepository implements PatientRepository {

  SupabasePatientRepository({
    required SupabaseClient supabaseClient
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<ActionResult> scheduleAppointment(PatientScheduleAppointmentEntity appointmentEntity) async {  
    try {
      await _supabaseClient.from('session')
      .insert(appointmentEntity.toMap());
      return ActionResultSuccess(
        data: 'Appointment scheduled successfully',
        statusCode: 200
      );
    } catch(e) {
      return ActionResultFailure(
        errorMessage: e.toString(),
        statusCode: 500
      );
    }
  }
  
  @override
  Future<ActionResult> getTherapyGoals({required DateTime date}) async {
    try {
      final response = await _supabaseClient.from('therapy_goal')
      .select('*')
      .eq('patient_id', _supabaseClient.auth.currentUser!.id);

      if (response.isEmpty) {
        return ActionResultFailure(
          errorMessage: 'No therapy goals found',
          statusCode: 404
        );
      }

      // Filter the results by date
      final filteredResponse = response.where((goal) {
        final goalDate = DateTime.parse(goal['performed_on']);
        return goalDate.year == date.year && 
               goalDate.month == date.month && 
               goalDate.day == date.day;
      }).toList();

      if (filteredResponse.isEmpty) {
        return ActionResultFailure(
          errorMessage: 'No therapy goals found for the specified date',
          statusCode: 404
        );
      }

      final therapist = await _supabaseClient.from('therapist')
      .select('*')
      .eq('id', filteredResponse.first['therapist_id']).maybeSingle();

      final therapyType = await _supabaseClient.from('therapy_type')
      .select('*')
      .eq('id', filteredResponse.first['therapy_type_id']).maybeSingle();

      final therapyGoal = TherapyGoalModelMapper.fromMap(filteredResponse.first);

      return ActionResultSuccess(data: therapyGoal.copyWith(
        therapistName: therapist?['name'],
        therapistPhone: therapist?['phone'],
        therapistEmail: therapist?['email'],
        therapyType: therapyType?['name'],
        therapyMode: filteredResponse.first['therapy_mode'],
        specialization: therapist?['specialisation']
      ), statusCode: 200);
      
    } catch(e) {
      return ActionResultFailure(
        errorMessage: e.toString(),
        statusCode: 500
      );
    }
  }
}