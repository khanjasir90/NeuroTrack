import 'package:flutter/material.dart';
import 'package:therapist/core/result/action_result_success.dart';
import 'package:therapist/core/utils/api_status_enum.dart';
import 'package:therapist/model/daily_activities/daily_activity_response_model.dart';

import '../core/repository/therapy/therapy_repository.dart';

class DailyActivitiesProvider extends ChangeNotifier {

  DailyActivitiesProvider({
    required TherapyRepository therapyRepository,
  }) : _therapyRepository = therapyRepository;

  final TherapyRepository _therapyRepository;

  
  ApiStatus _dailyActivitiesStatus = ApiStatus.initial;

  ApiStatus get dailyActivitiesStatus => _dailyActivitiesStatus;

  List<DailyActivityResponseModel> _dailyActivities = [];

  List<DailyActivityResponseModel> get dailyActivities => _dailyActivities;

  bool _isExpanded = true;
  bool get isExpanded => _isExpanded;

  Future<void> getDailyActivities(String patientId) async {
    try {
      _dailyActivitiesStatus = ApiStatus.loading;
      notifyListeners();
      final result = await _therapyRepository.getAllDailyActivities(patientId);
      if(result is ActionResultSuccess) {
        _dailyActivities = result.data as List<DailyActivityResponseModel>;
        _dailyActivitiesStatus = ApiStatus.success;
      } else {
        _dailyActivitiesStatus = ApiStatus.failure;
      }
      notifyListeners();
    } catch (e) {
      _dailyActivitiesStatus = ApiStatus.failure;
    }
  }

  void toggleExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}