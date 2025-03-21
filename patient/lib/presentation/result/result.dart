import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/google_signin_button.dart';
import '../widgets/welcome_header.dart';
import 'package:patient/presentation/result/book_appointment.dart';

// Initialize Supabase Client
final supabase = Supabase.instance.client;
final API_KEY = dotenv.env['GROQ_API_KEY'];

class ResultScreen extends StatefulWidget {
  final List<Map<String, String>> responses;
  final String patientId;

  const ResultScreen({
    Key? key, 
    required this.responses,
    required this.patientId,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String analysisResult = "";
  List<Map<String, dynamic>> therapists = [];
  bool isLoading = true;
  int score = 80; // This would come from your analysis or be calculated

  @override
  void initState() {
    super.initState();
    analyzeResponses();
    fetchTherapists();
  }

  // Send responses to Groq API for analysis
  Future<void> analyzeResponses() async {
    if (widget.responses.isEmpty) {
      setState(() {
        analysisResult = "No responses to analyze.";
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "model": "llama3-8b-8192",
          "messages": [
            {
              "role": "system",
              "content": "Analyze the following assessment responses related to potential autism traits and provide insights, potential therapy goals, and daily activities that might be beneficial. Be concise and informative."
            },
            {
              "role": "user",
              "content": widget.responses.map((res) => "Question: ${res['question']}, Answer: ${res['answer']}").join("\n")
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          setState(() {
            analysisResult = data['choices'][0]['message']['content'] ?? "Analysis unavailable.";
            isLoading = false;
          });
        } else {
          setState(() {
            analysisResult = "Could not extract analysis from the API response.";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          analysisResult = "Failed to analyze responses. Status code: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        analysisResult = "Error connecting to analysis service: $e";
        isLoading = false;
      });
    }
  }

  // Fetch therapist data from Supabase
  Future<void> fetchTherapists() async {
    try {
      final response = await supabase.from("therapist").select();
      setState(() {
        therapists = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print("Error fetching therapists: $e");
    }
  }

  void navigateToTherapyGoals() {
    // Navigate to therapy goals screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TherapyGoalsScreen(
          patientId: widget.patientId,
          analysisResult: analysisResult,
        ),
      ),
    );
  }

  void navigateToDailyActivities() {
    // Navigate to daily activities screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyActivitiesScreen(
          patientId: widget.patientId,
          analysisResult: analysisResult,
        ),
      ),
    );
  }

  void bookAppointment(Map<String, dynamic> therapist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TherapistDetailsScreen(
          therapist: therapist,
          patientId: widget.patientId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results", style: TextStyle(fontWeight: FontWeight.w500)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Score Circle
                    // Replace the CircularPercentIndicator with this custom implementation
Center(
  child: Container(
    width: 160,
    height: 160,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: CircularProgressIndicator(
            value: score / 100,
            strokeWidth: 15,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            strokeCap: StrokeCap.round,
          ),
        ),
        Text(
          "$score",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36.0,
          ),
        ),
      ],
    ),
  ),
),
                    const SizedBox(height: 12),
                    // Congratulations text
                    Center(
                      child: Text(
                        "Congratulations, you are in the top 5%\nin NeuroTrack",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Improvement text
                    const Text(
                      "Wanna improve? Here's how",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Therapy Goals and Daily Activities cards
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: navigateToTherapyGoals,
                            child: Card(
                              elevation: 0,
                              color: Colors.amber.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/illustration1.png',
                                      height: 70,
                                      width: 70,
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      "Therapy\nGoals",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: navigateToDailyActivities,
                            child: Card(
                              elevation: 0,
                              color: Colors.amber.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/illustration.png',
                                      height: 70,
                                      width: 70,
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      "Daily\nActivities",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Therapist list text
                    const Text(
                      "We have curated a list of\ndoctors for your ease",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Therapist list
                    therapists.isEmpty
                        ? const Center(child: Text("Loading therapists..."))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: therapists.length > 3 ? 3 : therapists.length,
                            itemBuilder: (context, index) {
                              final therapist = therapists[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      // Therapist Avatar
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          therapist["avatar_url"] ?? 
                                          "https://via.placeholder.com/50",
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Therapist Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              therapist["name"] ?? "Therapist Name",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              therapist["specialisation"] ?? "Neurologist",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "Duration",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "1 hour 30 mins",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Book Now Button
                                      TextButton(
                                        onPressed: () => bookAppointment(therapist),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: const Text(
                                          "BOOK NOW",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

// Placeholder screens that would need to be implemented
class TherapyGoalsScreen extends StatelessWidget {
  final String patientId;
  final String analysisResult;

  const TherapyGoalsScreen({
    Key? key,
    required this.patientId,
    required this.analysisResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Therapy Goals")),
      body: const Center(child: Text("Therapy Goals Content")),
    );
  }
}

class DailyActivitiesScreen extends StatelessWidget {
  final String patientId;
  final String analysisResult;

  const DailyActivitiesScreen({
    Key? key,
    required this.patientId,
    required this.analysisResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Activities")),
      body: const Center(child: Text("Daily Activities Content")),
    );
  }
}

class BookAppointmentScreen extends StatelessWidget {
  final Map<String, dynamic> therapist;
  final String patientId;

  const BookAppointmentScreen({
    Key? key,
    required this.therapist,
    required this.patientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Appointment")),
      body: Center(child: Text("Book appointment with ${therapist['name']}")),
    );
  }
}