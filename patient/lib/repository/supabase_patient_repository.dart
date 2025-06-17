import 'package:patient/core/result/result.dart';
import 'package:patient/presentation/appointments/models/appointment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/entities/entities.dart';
import '../core/repository/repository.dart';

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
  Future<ActionResult> fetchAllAppointments() async {
    try {
      final response = await _supabaseClient.from('session').select('*').eq('patient_id', _supabaseClient.auth.currentUser!.id);
       if (response.isEmpty) {
        return ActionResultFailure(
          errorMessage: 'No consultation requests found',
          statusCode: 404
        );
      }
      final data = response as List<dynamic>;

      final consultationData = data.map((session) {
        return AppointmentModel(
          id: session['id'],
          serviceType: session['is_consultation'] ? 'Consultation' : 'Therapy Session',
          appointmentDate: DateTime.parse(session['timestamp']),
          timeSlot: session['timestamp'],
          isCompleted: DateTime.parse(session['timestamp']).isBefore(DateTime.now())
        );
      }).toList();

      return ActionResultSuccess(data: consultationData, statusCode: 200);
    } catch(e) {
      return ActionResultFailure(
        errorMessage: e.toString(),
        statusCode: 500
      );
    }
  }

  @override
  Future<ActionResult> deleteAppointment(String id) async {
    try {
      await _supabaseClient.from('session').delete().eq('id', id);
      return ActionResultSuccess(
        data: 'Appointment deleted successfully',
        statusCode: 200
      );
    } catch(e) {
      return ActionResultFailure(
        errorMessage: e.toString(),
        statusCode: 500
      );
    }
  }
}
