import 'package:flutter/foundation.dart';
import 'package:patient/core/core.dart';
import 'package:patient/model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<PatientTaskModel> _allTasks = [];
  DateTime _selectedDate = DateTime.now();
  final PatientRepository _patientRepository;
  ApiStatus _apiStatus = ApiStatus.initial;

  TaskProvider({
    required PatientRepository patientRepository,
  }): _patientRepository = patientRepository {
    //getTodayActivities(); // TODO: Uncomment this when the backend is ready
    _initializeTasks();
  }

  // TODO: Remove this method when the backend is ready
  // Dummy data for demo purposes

  void _initializeTasks() {
    // Created tasks for demo purposes
    // TODO: Replace demo tasks with backend data from supabase
    final today = DateTime.now();

    _allTasks.addAll([
      PatientTaskModel(activityId: '1', activityName: 'Brush Teeth', isCompleted: false),
      PatientTaskModel(activityId: '2', activityName: 'Have Breakfast', isCompleted: false),
      PatientTaskModel(activityId: '3', activityName: 'Take Medications', isCompleted: false),
      PatientTaskModel(activityId: '4', activityName: 'Morning Walk', isCompleted: false),
      PatientTaskModel(activityId: '5', activityName: 'Read a Book', isCompleted: false),
    ]);
    notifyListeners();
  }


  Future<void> getTodayActivities({
    DateTime? date,
  }) async {
    try {
      _apiStatus = ApiStatus.loading;
      notifyListeners();
      final result = await _patientRepository.getTodayActivities(date: date);
      if(result is ActionResultSuccess) {
        _allTasks = result.data as List<PatientTaskModel>;
        _apiStatus = ApiStatus.success;
      } else {
        _apiStatus = ApiStatus.failure;
      }
      notifyListeners();
    } catch(e) {
      _apiStatus = ApiStatus.failure;
    } finally {
      notifyListeners();
    }
  }

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    //updateActivityInBackground(); // TODO: Uncomment this when the backend is ready
    //getTodayActivities(date: date); // TODO: Uncomment this when the backend is ready
    notifyListeners();
  }

  List<PatientTaskModel> get tasks {
    return _allTasks;
  }

  void toggleTaskCompletion(String activityId, bool isCompleted) async {
    _allTasks = _allTasks.map(
      (task) => task.activityId == activityId ? task.copyWith(isCompleted: isCompleted) : task)
      .toList();
    notifyListeners();
  }

  void updateActivityInBackground() {
    compute(_updateActivityCompletion, _allTasks);
  }

  Future<void> _updateActivityCompletion(List<PatientTaskModel> tasks) async {
    try {
      await _patientRepository.updateActivityCompletion(tasks);
    } catch(e) {
      print(e);
    }
  }

  int get completedTasksCount => tasks.where((task) => task.isCompleted ?? false).length;
  int get totalTasksCount => tasks.length;
}
