import 'package:patient/core/entities/patient_entities/patient_schedule_appointment_entity.dart';
import 'package:patient/core/result/result.dart';

abstract interface class PatientRepository {

  /// Schedules an appointment by inserting a new record into the `session` table.
  ///
  /// This method takes a [PatientScheduleAppointmentEntity] object, converts it to a map,
  /// and inserts it into the `session` table using Supabase.
  ///
  /// - **Parameters:**  
  ///   - `appointmentEntity` : An instance of [PatientScheduleAppointmentEntity]  
  ///     containing appointment details.
  ///
  /// - **Returns:**  
  ///   - A [Future] of [ActionResult], which can either be:  
  ///     - [ActionResultSuccess] with a success message and status code `200` if the appointment  
  ///       is successfully scheduled.  
  ///     - [ActionResultFailure] with an error message and status code `500` if an exception occurs.
  ///
  /// - **Exceptions:**  
  ///   - If an error occurs while inserting the record, it is caught and returned as a failure.
  
  Future<ActionResult> scheduleAppointment(PatientScheduleAppointmentEntity appointmentEntity);

  Future<ActionResult> getTherapyGoals({
    required DateTime date,
  });
  /// Fetches all appointments from the `session` table.
  ///
  /// This method fetches all appointments from the `session` table using Supabase.
  ///
  /// - **Returns:**
  ///   - A [Future] of [ActionResult], which can either be:
  ///     - [ActionResultSuccess] with a success message and status code `200` if the appointments are successfully fetched.
  ///     - [ActionResultFailure] with an error message and status code `500` if an exception occurs.
  ///
  /// - **Exceptions:**
  ///   - If an error occurs while fetching the appointments, it is caught and returned as a failure.
  Future<ActionResult> fetchAllAppointments();

  /// Deletes an appointment from the `session` table.
  ///
  /// This method deletes an appointment from the `session` table using Supabase.
  ///
  /// - **Parameters:**
  ///   - `id` : The ID of the appointment to be deleted.
  ///
  /// - **Returns:**
  ///   - A [Future] of [ActionResult], which can either be:
  ///     - [ActionResultSuccess] with a success message and status code `200` if the appointment is successfully deleted.
  ///     - [ActionResultFailure] with an error message and status code `500` if an exception occurs.
  ///
  /// - **Exceptions:**
  ///   - If an error occurs while deleting the appointment, it is caught and returned as a failure.
  Future<ActionResult> deleteAppointment(String id);
 
}