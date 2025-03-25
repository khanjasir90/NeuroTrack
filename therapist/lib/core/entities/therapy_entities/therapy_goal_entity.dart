import 'package:dart_mappable/dart_mappable.dart';
import 'package:therapist/model/therapy_models/therapy_model.dart';

part 'therapy_goal_entity.mapper.dart';

@MappableClass()
class TherapyGoalEntity with TherapyGoalEntityMappable {

  @MappableField(key: 'performed_on')
  final DateTime performedOn;

  @MappableField(key: 'therapist_id')
  final String therapistId;

  @MappableField(key: 'therapy_id')
  final String therapyId;

  @MappableField(key: 'goals')
  final List<TherapyModel> goals;

  @MappableField(key: 'observations')
  final List<TherapyModel> observations;

  @MappableField(key: 'regressions')
  final List<TherapyModel> regressions;

  @MappableField(key: 'activities')
  final List<TherapyModel> activities;

  @MappableField(key: 'therapy_date')
  final String therapyDate;


  TherapyGoalEntity({
    required this.performedOn,
    required this.therapistId,
    required this.therapyId,
    required this.goals,
    required this.observations,
    required this.regressions,
    required this.activities,
    required this.therapyDate
  });
}