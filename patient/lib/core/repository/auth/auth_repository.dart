import 'package:patient/core/entities/auth_entities/personal_info_entity.dart';
import 'package:patient/core/result/result.dart';

abstract interface class AuthRepository {
  // The abstract repository class will define the methods that the repository must implement.
  
  // Method to sign in with Google with [SUPABASE] as a provider
  Future<ActionResult> signInWithGoogle();

  /// Stores the personal information of the patient in the `patient` table.
  /// 
  /// This method takes a [PersonalInfoEntity] object, converts it to a map,
  /// and inserts it into the `patient` table using Supabase.
  /// 
  /// - **Parameters:**
  ///  - `personalInfoEntity` : An instance of [PersonalInfoEntity] containing
  ///   personal information of the patient.
  /// 
  /// - **Returns:**
  /// - A [Future] of [ActionResult], which can either be:
  ///  - [ActionResultSuccess] with a success message and status code `200` if the personal
  ///  information is successfully stored.
  /// - [ActionResultFailure] with an error message and status code `400` if an exception occurs.
  /// 
  /// - **Exceptions:**
  /// - If an error occurs while inserting the record, it is caught and returned as a failure.
  
  Future<ActionResult> storePersonalInfo(PersonalInfoEntity personalInfoEntity);

  /// Checks if the patient already exists in the `patient` table.
  /// 
  /// This method checks if the patient already exists in the `patient` table
  /// using the `patient_id` from the [PersonalInfoEntity].
  /// 
  /// - **Returns:**
  /// - A [Future] of [ActionResult], which can either be:
  /// - [ActionResultSuccess] with a success message and status code `200` if the patient
  /// exists in the `patient` table.
  /// - [ActionResultFailure] with an error message and status code `400` if the patient
  /// does not exist in the `patient` table.
  /// 
  /// - **Exceptions:**
  /// - If an error occurs while checking if the patient exists, it is caught and returned as a failure.

  Future<ActionResult> checkIfPatientExists();

}
