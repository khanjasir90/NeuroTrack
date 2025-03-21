import 'package:therapist/core/result/result.dart';

abstract interface class ConsultationRepository {
  /// Fetches all consultation requests for the current therapist.
  /// 
  /// This method retrieves all consultation requests associated with the 
  /// currently authenticated therapist from the database.
  /// 
  /// - **Returns:**
  /// - A [Future] of [ActionResult], which can either be:
  /// - [ActionResultSuccess] with a list of consultation requests and status code `200` 
  ///   if the requests are successfully fetched.
  /// - [ActionResultFailure] with an error message and status code `400` if an exception occurs.
  Future<ActionResult> fetchConsultationRequests();

  /// Retrieves a specific consultation request by its ID.
  /// 
  /// This method fetches a single consultation request with the provided ID.
  /// 
  /// - **Parameters:**
  /// - `requestId`: The unique identifier of the consultation request to retrieve.
  /// 
  /// - **Returns:**
  /// - A [Future] of [ActionResult], which can either be:
  /// - [ActionResultSuccess] with the consultation request and status code `200` 
  ///   if the request is successfully fetched.
  /// - [ActionResultFailure] with an error message and status code `400` if an exception occurs
  ///   or if the request is not found.
  Future<ActionResult> getConsultationRequestById(String requestId);

  /// Updates the status of a consultation request.
  /// 
  /// This method changes the status of a consultation request and optionally sets
  /// a scheduled time and notes.
  /// 
  /// - **Parameters:**
  /// - `requestId`: The unique identifier of the consultation request to update.
  /// - `status`: The new status for the request ('accepted', 'declined', 'pending').
  /// - `scheduledTime`: Optional. The scheduled time for the consultation if accepted.
  /// - `notes`: Optional. Any notes related to the status change.
  /// 
  /// - **Returns:**
  /// - A [Future] of [ActionResult], which can either be:
  /// - [ActionResultSuccess] with a success message and status code `200` 
  ///   if the status is successfully updated.
  /// - [ActionResultFailure] with an error message and status code `400` if an exception occurs.
  Future<ActionResult> updateRequestStatus({
    required String requestId,
    required String status,
    DateTime? scheduledTime,
    String? notes,
  });
}