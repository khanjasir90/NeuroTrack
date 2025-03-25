import 'package:therapist/core/result/action_result.dart';

abstract interface class TherapyRepository {
  Future<ActionResult> getTherapyTypes();
  Future<ActionResult> addTherapyGoals(String therapyTypeId, String goal);
  Future<ActionResult> addTherapyObservations(String therapyTypeId, String observation);
  Future<ActionResult> addTherapyRegressions(String therapyTypeId, String regression);
  Future<ActionResult> addTherapyActivities(String therapyTypeId, String activity);
  Future<ActionResult> getAllGoals(String therapyTypeId);
  Future<ActionResult> getAllObservations(String therapyTypeId);
  Future<ActionResult> getAllRegressions(String therapyTypeId);
  Future<ActionResult> getAllActivities(String therapyTypeId);
}