import 'package:flutter/material.dart';
import 'package:therapist/presentation/daily_activities/widgets/daily_activities_set_card.dart';

class DailyActivitiesScreen extends StatelessWidget {
  const DailyActivitiesScreen({super.key});

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Image.asset(
          'assets/arrow_left.png',
          width: 24,
          height: 24,
        ),
      ),
      title: const Text(
        'Daily Activities',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            ActivitySetCard(
              title: 'Running Activities',
              isExpanded: true,
              isActive: false,
              activities: [
                'Run for 10 minutes',
                'Walk for 10 minutes',
                'Cycle for 10 minutes',
                'Swim for 10 minutes',
                'Dance for 10 minutes',
                'Yoga for 10 minutes',
                'Meditation for 10 minutes',
              ],
              onExpandToggle: () {},
              onActiveToggle: (bool isActive) {},
              selectedDays: [],
            ),
          ],
        ),
      ),
    );
  }
}