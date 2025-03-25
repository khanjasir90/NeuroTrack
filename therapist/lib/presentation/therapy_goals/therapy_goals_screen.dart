import 'package:flutter/material.dart';
import 'package:therapist/presentation/therapy_goals/widgets/save_therapy_button.dart';
import 'package:therapist/presentation/therapy_goals/widgets/therapy_container.dart';

class TherapyGoalsScreen extends StatelessWidget {
  const TherapyGoalsScreen({super.key});

  AppBar _getAppBar() {
    return AppBar(
      leading: Image.asset(
        'assets/arrow_left.png',
        width: 24,
        height: 24,
      ),
      title: const Text(
        'Tailored Goals',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
        child: SaveTherapyButton(
          text: 'Save Therapy Details',
          onPressed: () {},
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(left: 22, right: 22, top: 22),
        child: Column(
          spacing: 30,
          children: [
            TherapyContainer(
              therapyDetailsType: TherapyDetailsType.goals,
              therapyInfo: [], // ['Brush Teeth', 'Reading Books', 'Exercise'],
            ),
            TherapyContainer(
              therapyDetailsType: TherapyDetailsType.observation,
              therapyInfo: ['Brush Teeth', 'Reading Books', 'Exercise'],
            ),
            TherapyContainer(
              therapyDetailsType: TherapyDetailsType.regression,
              therapyInfo: [], //['Brush Teeth', 'Reading Books', 'Exercise'],
            ),
            TherapyContainer(
              therapyDetailsType: TherapyDetailsType.activities,
              therapyInfo: ['Brush Teeth', 'Reading Books', 'Exercise'],
            ),
          ],
        ),
      ),
    );
  }
}
