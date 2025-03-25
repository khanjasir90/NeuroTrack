import 'package:therapist/core/result/action_result.dart';

abstract interface class TherapyRepository {
  Future<ActionResult> getTherapyTypes();
}