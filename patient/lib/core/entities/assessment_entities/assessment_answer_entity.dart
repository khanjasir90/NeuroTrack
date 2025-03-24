import 'package:dart_mappable/dart_mappable.dart';

import 'assessment_question_answer_entity.dart';

part 'assessment_answer_entity.mapper.dart';

@MappableClass()
class AssessmentAnswerEntity with AssessmentAnswerEntityMappable {

  @MappableField(key: 'assessment_id')
  final String assessmentId;

  @MappableField(key: 'questions')
  final List<AssessmentQuestionAnswerEntity> questions;

  AssessmentAnswerEntity({
    required this.assessmentId,
    required this.questions,
  });

}