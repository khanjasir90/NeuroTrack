import 'package:flutter/material.dart';
import 'package:patient/presentation/assessments/models/assessment_card_model.dart';

class AssessmentIcon extends StatelessWidget {
  final AssessmentCardModel assessment;

  const AssessmentIcon({
    super.key,
    required this.assessment,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assessment.iconPath,
      width: 80,
      height: 80,
      fit: BoxFit.contain,
    );
  }
}
