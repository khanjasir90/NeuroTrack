import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient/presentation/assessments/models/assessment_card_model.dart';
import 'package:patient/repository/supabase_assessments_repository.dart';

class AssessmentProvider with ChangeNotifier {
  final SupabaseAssessmentsRepository _repository =
      SupabaseAssessmentsRepository();
  Map<String, dynamic>? _assessment;
  Map<int, String?> _selectedAnswers = {};
  String? _assessmentId;

  String? get assessmentId => _assessmentId;
  Map<String, dynamic>? get assessment => _assessment;
  Map<int, String?> get selectedAnswers => _selectedAnswers;

  final List<AssessmentCardModel> assessments = [
    const AssessmentCardModel(
      id: 'autism_quotient',
      title: 'Autism Quotient(AQ)',
      description: 'A quick referral guide to adults with suspected autism',
      iconPath: 'assets/autism_icon.png',
    ),
    const AssessmentCardModel(
      id: 'asrs_5',
      title: 'ASRS-5',
      description:
          'The Adult ADHD Self-Report Scale for DSM-5 (ASRS-5) is a self-report screening scale for ADHD in adults',
      iconPath: 'assets/adhd_icon.png',
    ),
    const AssessmentCardModel(
      id: 'aq_10',
      title: 'AQ-10',
      description:
          'The AQ-10 is a quick questionnaire that primary care practitioners can use to see if a person should be referred for an autism assessment.',
      iconPath: 'assets/aq10_icon.png',
    ),
  ];
  Future<void> fetchAssessmentBySelectedId() async {
    try {
      //for testing purposes, the assessment id is hardcoded in the .env file and directly passing it if the assessment id is not set
      //otherwise, the assessment id is fetched from the assessment id set by the user
      final assessments = await _repository.fetchAssessmentById(
          _assessmentId ?? dotenv.env['Austim_Spectrum_Assement_Id']!);
      if (assessments.isNotEmpty) {
        _assessment = assessments.first;
        _selectedAnswers = {
          for (int i = 0; i < _assessment!['questions'].length; i++) i: null
        };
      } else {
        _assessment = null;
        _selectedAnswers.clear();
      }
      notifyListeners();
    } catch (e) {
      // debugPrint('Error fetching assessment: $e');
      _assessment = null;
      _selectedAnswers.clear();
      notifyListeners();
    }
  }

  void selectAnswer(int questionIndex, String answer) {
    if (_assessment != null &&
        questionIndex >= 0 &&
        questionIndex < _assessment!['questions'].length) {
      _selectedAnswers[questionIndex] = answer;
      notifyListeners();
    }
  }

  //implement the submitAssessment method to submit the assessment when the submitted_assessment table is created
  Future<void> submitAssessment() async {}

  //setAssessmentId method can be used to set the assessment id
  void setAssessmentId(String id) {
    _assessmentId = id;
    notifyListeners();
  }
}
