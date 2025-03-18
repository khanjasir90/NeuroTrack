import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:patient/presentation/result/book_appointment.dart';

// Initialize Supabase Client
final supabase = Supabase.instance.client;

class ResultScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const ResultScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  double correctPercentage = 0.0;
  String therapyGoals = "";
  String dailyActivities = "";
  List<Map<String, dynamic>> therapists = [];

  @override
  void initState() {
    super.initState();
    analyzeResults();
    fetchTherapists();
  }

  // Send incorrect answers to Groq API
  Future<void> analyzeResults() async {
    List<Map<String, dynamic>> incorrectAnswers = widget.questions
        .where((q) => q["isCorrect"] == false)
        .toList();

    int correctCount = widget.questions.where((q) => q["isCorrect"] == true).length;
    correctPercentage = (correctCount / widget.questions.length) * 100;

    if (incorrectAnswers.isNotEmpty) {
      final response = await http.post(
        Uri.parse("https://api.groq.com/analyze"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"incorrectAnswers": incorrectAnswers}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          therapyGoals = data["therapy_goals"];
          dailyActivities = data["daily_activities"];
        });
      }
    }
  }

  // Fetch therapist data from Supabase
  Future<void> fetchTherapists() async {
    final response = await supabase.from("therapist").select();
    setState(() {
      therapists = List<Map<String, dynamic>>.from(response);
    });
  }

  // Navigate to therapist details screen
  void goToTherapistDetails(Map<String, dynamic> therapist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TherapistDetailsScreen(therapist: therapist, patientId: "1"), // Pass patient ID
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Correct Answers: ${correctPercentage.toStringAsFixed(2)}%", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Therapy Goals:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(therapyGoals),
            SizedBox(height: 10),
            Text("Daily Activities to Improve Autism:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(dailyActivities),
            SizedBox(height: 20),
            Text("Available Therapists:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: therapists.length,
                itemBuilder: (context, index) {
                  final therapist = therapists[index];
                  return ListTile(
                    title: Text(therapist["name"]),
                    subtitle: Text(therapist["specialisation"]),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () => goToTherapistDetails(therapist),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
