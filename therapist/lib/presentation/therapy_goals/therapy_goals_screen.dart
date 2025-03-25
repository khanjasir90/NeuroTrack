import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist/presentation/therapy_goals/widgets/save_therapy_button.dart';
import 'package:therapist/presentation/therapy_goals/widgets/therapy_container.dart';
import 'package:therapist/presentation/therapy_goals/widgets/therapy_date_time_picker.dart';
import 'package:therapist/presentation/therapy_goals/widgets/therapy_type_field.dart';
import 'package:therapist/provider/therapy_provider.dart';

class TherapyGoalsScreen extends StatefulWidget {
  const TherapyGoalsScreen({super.key});

  @override
  State<TherapyGoalsScreen> createState() => _TherapyGoalsScreenState();
}

class _TherapyGoalsScreenState extends State<TherapyGoalsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TherapyProvider>().getThearpyType();
  }

  AppBar _getAppBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Image.asset(
          'assets/arrow_left.png',
          width: 24,
          height: 24,
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
        child: Column(
          spacing: 30,
          children: [
            Consumer<TherapyProvider>(
              builder: (context, provider,child) {
                return TherapyTypeField(
                  selectedTherapyType: provider.selectedTherapyType,
                  therapyType: provider.therapyTypes,
                  onChanged: (value) {
                    provider.setSelectedTherapyType = value ?? '';
                  },
                );
              }
            ),
            TherapyDateTimePicker(
              label: 'Therapy Date',
              icon: Icons.calendar_month_outlined,
              onTap: () {},
            ),
            Consumer<TherapyProvider>(
              builder: (context, provider, child) {
                return TherapyContainer(
                  therapyDetailsType: TherapyDetailsType.goals,
                  therapyInfo: provider
                      .selectedTherapyGoals, 
                );
              },
            ),
            Consumer<TherapyProvider>(
              builder: (context, provider, child) {
                return TherapyContainer(
                  therapyDetailsType: TherapyDetailsType.observation,
                  therapyInfo: provider
                      .selectedTherapyObservations, 
                );
              },
            ),
            Consumer<TherapyProvider>(
              builder: (context, provider, child) {
                return TherapyContainer(
                  therapyDetailsType: TherapyDetailsType.regression,
                  therapyInfo: provider
                      .selectedTherapyRegressions, 
                );
              },
            ),
            Consumer<TherapyProvider>(
              builder: (context, provider, child) {
                return TherapyContainer(
                  therapyDetailsType: TherapyDetailsType.activities,
                  therapyInfo: provider
                      .selectedTherapyActivities,
                );
              },
            ), 
          ],
        ),
      ),
    );
  }
}
