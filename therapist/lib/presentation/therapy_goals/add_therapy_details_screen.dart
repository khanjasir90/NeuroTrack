import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist/core/theme/theme.dart';
import 'package:therapist/presentation/therapy_goals/widgets/add_new_bottom_sheet.dart';
import 'package:therapist/provider/therapy_provider.dart';

import 'widgets/therapy_container.dart';

class AddTherapyDetailsScreen extends StatelessWidget {
  const AddTherapyDetailsScreen({
    super.key,
    required this.therapyDetailsType,
  });

  final TherapyDetailsType therapyDetailsType;

  void callAddNewTherapyData(BuildContext context, String value) {
    switch (therapyDetailsType) {
      case TherapyDetailsType.goals:
        Provider.of<TherapyProvider>(context, listen: false).addTherapyGoals(value);
        break;
      case TherapyDetailsType.observation:
        Provider.of<TherapyProvider>(context, listen: false).addTherapyObservations(value);
        break;
      case TherapyDetailsType.regression:
        Provider.of<TherapyProvider>(context, listen: false).addTherapyRegressions(value);
        break;
      case TherapyDetailsType.activities:
        Provider.of<TherapyProvider>(context, listen: false).addTherapyActivities(value);
        break;
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewBottomSheet(
          therapyDetailsType: therapyDetailsType,
          onSumbit:(String value) {
            callAddNewTherapyData(context, value);
            Navigator.of(context).pop();
          }
        );
      },
    );
  }

  String get _getTherapyDetailsText {
    switch (therapyDetailsType) {
      case TherapyDetailsType.goals:
        return 'Add Therapy Goals';
      case TherapyDetailsType.observation:
        return 'Add Therapy Observation';
      case TherapyDetailsType.regression:
        return 'Add Regression';
      case TherapyDetailsType.activities:
        return 'Add Activities';
    }
  }


  AppBar _getAppBar(BuildContext context) {
    return AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/arrow_left.png',
           width: 24,
           height: 24,
          ),
        ),
        title:  Text(
          _getTherapyDetailsText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: const BoxDecoration(
            shape: BoxShape.circle
          ),
          child: FloatingActionButton(
            onPressed: () => _showBottomSheet(context),
            backgroundColor: AppTheme.primaryColor,
            child: const Icon(Icons.add),
          ),
        ),
      ),
      appBar: _getAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          spacing: 2,
          children: [
            _BuildOptionTile(),
            _BuildOptionTile(),
            _BuildOptionTile(),
            _BuildOptionTile(),
            _BuildOptionTile(),
          ],
        ),
      ),
    );
  }
}

class _BuildOptionTile extends StatelessWidget {
  const _BuildOptionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: AppTheme.primaryColor,
            value: true,
            onChanged: (value) {}),
        const Text('Brush Teeth'),
      ],
    );
  }
}