import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist/core/utils/api_status_enum.dart';
import 'package:therapist/presentation/daily_activities/widgets/daily_activities_set_card.dart';

import '../../provider/daily_activities_provider.dart';

class DailyActivitiesScreen extends StatefulWidget {
  const DailyActivitiesScreen({
    super.key,
    required this.patientId,
  });

  final String patientId;

  @override
  State<DailyActivitiesScreen> createState() => _DailyActivitiesScreenState();
}

class _DailyActivitiesScreenState extends State<DailyActivitiesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<DailyActivitiesProvider>()
          .getDailyActivities(widget.patientId);
    });
  }

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
      body: Consumer<DailyActivitiesProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                if(provider.dailyActivitiesStatus == ApiStatus.loading) ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ] else if(provider.dailyActivitiesStatus == ApiStatus.success) ...[
                  ListView.builder(
                    itemCount: provider.dailyActivities.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final dailyActivity = provider.dailyActivities[index];
                      return ActivitySetCard(
                        title: dailyActivity.activityName,
                        isExpanded: provider.isExpanded,
                        isActive: dailyActivity.isActive,
                        activities: dailyActivity.activityList.map((e) => e.activity).toList(),
                        onExpandToggle: () {
                          provider.toggleExpanded();
                        },
                        onActiveToggle: (bool isActive) {},
                        selectedDays: () {
                          final daysOfWeek = dailyActivity.daysOfWeek;
                          final List<bool> selectedDays = [];
                          for(int i = 1; i <= 7; i++) {
                            selectedDays.add(daysOfWeek.contains(i.toString()));
                          }
                          return selectedDays;
                        }(),
                      );
                    },
                  )
                ] else ...[
                  const Center(child: Text('No daily activities found'),)
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
