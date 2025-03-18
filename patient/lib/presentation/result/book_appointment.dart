import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize Supabase Client
final supabase = Supabase.instance.client;

class TherapistDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> therapist;
  final String patientId; // Pass Patient ID dynamically

  const TherapistDetailsScreen({
    Key? key,
    required this.therapist,
    required this.patientId,
  }) : super(key: key);

  @override
  _TherapistDetailsScreenState createState() => _TherapistDetailsScreenState();
}

class _TherapistDetailsScreenState extends State<TherapistDetailsScreen> {
  bool isLoading = false;

  Future<void> bookAppointment() async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Appointment"),
        content: Text("Are you sure you want to book an appointment with ${widget.therapist["name"]}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Confirm")),
        ],
      ),
    );

    if (!confirm) return;

    setState(() => isLoading = true);

    try {
      await supabase.from("session").insert({
        "therapist_id": widget.therapist["id"],
        "patient_id": widget.patientId,
        "timestamp": DateTime.now().toIso8601String(),
        "mode": 1,
        "duration": 60,
        "name": widget.therapist["name"],
        "status": "pending"
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Appointment booked successfully!"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error booking appointment: $e"))
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.therapist["name"])),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image Placeholder
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/doctor_placeholder.png"), // Replace with actual image URL if available
              child: widget.therapist["image_url"] != null
                  ? Image.network(widget.therapist["image_url"], fit: BoxFit.cover)
                  : null,
            ),
            SizedBox(height: 10),

            // Therapist Details in a Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildDetailRow(Icons.person, "Name", widget.therapist["name"]),
                    buildDetailRow(Icons.email, "Email", widget.therapist["email"]),
                    buildDetailRow(Icons.phone, "Phone", widget.therapist["phone"]),
                    buildDetailRow(Icons.badge, "Specialisation", widget.therapist["specialisation"]),
                    buildDetailRow(Icons.healing, "Offered Therapies", widget.therapist["offered_therapies"]?.join(", ") ?? "Not available"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Book Appointment Button
            ElevatedButton.icon(
              onPressed: isLoading ? null : bookAppointment,
              icon: Icon(Icons.calendar_today),
              label: isLoading ? CircularProgressIndicator(color: Colors.white) : Text("Book Appointment"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build rows for therapist details
  Widget buildDetailRow(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }
}
