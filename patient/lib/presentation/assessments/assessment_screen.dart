import 'package:flutter/material.dart';
import 'package:patient/core/theme/theme.dart';
import 'package:patient/provider/assessment_provider.dart';
import 'package:provider/provider.dart';

class AssessmentScreen extends StatefulWidget {
  final String assessmentId;
  const AssessmentScreen({super.key, required this.assessmentId});

  @override
  AssessmentScreenState createState() => AssessmentScreenState();
}

class AssessmentScreenState extends State<AssessmentScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AssessmentProvider>(context, listen: false)
        .fetchAssessmentById(widget.assessmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AssessmentProvider>(
          builder: (context, provider, child) {
            if (provider.assessment == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.secondaryColor,
                ),
              );
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    "Autism Quotient (AQ)",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tell us a bit about yourself',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListView.builder(
                        itemCount:
                            (provider.assessment!['questions'] as List).length,
                        itemBuilder: (context, index) {
                          final question =
                              provider.assessment!['questions'][index];
                          return QuestionCard(
                            question: question, 
                            questionIndex: index,
                            onAnswerSelected: (value) {
                              provider.selectAnswer(index, value);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {

                          // Implement Submit Assessment logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2, // Small shadow effect
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Submit Assessment',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Reusable QuestionCard Widget with Custom Checkbox
class QuestionCard extends StatelessWidget {
  final Map<String, dynamic> question;
  final int questionIndex;
  final ValueChanged<String> onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          question['text'] as String,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        ...List<Map<String, dynamic>>.from(question['options']).map((option) {
          final optionText = option['text'] as String;
          final isSelected =
              provider.selectedAnswers[questionIndex] == optionText;
          return SizedBox(
            height: 30,
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (bool? value) {
                    if (value == true) {
                      onAnswerSelected(optionText);
                    } else {
                      onAnswerSelected('');
                    }
                  },
                  activeColor: AppTheme.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  side: const BorderSide(
                    color: Color(0xFF666666),
                    width: 1.5,
                  ),
                ),
                Text(
                  optionText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.subtitleColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
