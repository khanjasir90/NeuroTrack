import 'package:flutter/material.dart';
import 'package:patient/core/theme/theme.dart';
import 'package:patient/presentation/assessments/assessment_screen.dart';
import 'package:patient/presentation/assessments/widgets/assessment_card.dart';
import 'package:patient/provider/assessment_provider.dart';
import 'package:provider/provider.dart';

class AssessmentsListScreen extends StatelessWidget {
  const AssessmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final assessmentProvider =
        Provider.of<AssessmentProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Assessment',
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Select assessment you\'d like to take',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  color: AppTheme.subtitleColor,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: assessmentProvider.assessments.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final assessment = assessmentProvider.assessments[index];
                    return AssessmentCard(
                      assessment: assessment,
                      onTap: () {
                        // Handle assessment selection
                        //update the assessment id in the provider by using the setAssessmentId method for e.g:
                        // Provider.of<AssessmentProvider>(context, listen: false)
                        //     .setAssessmentId(assessment.id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AssessmentScreen()));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
