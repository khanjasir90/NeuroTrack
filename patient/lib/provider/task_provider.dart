import 'package:flutter/foundation.dart';
import 'package:patient/model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<PatientTaskModel> _allTasks = [];
  DateTime _selectedDate = DateTime.now();

  TaskProvider() {
    _initializeTasks();
  }

  void _initializeTasks() {
    // Created tasks for demo purposes
    // TODO: Replace demo tasks with backend data from supabase
    final today = DateTime.now();

    _allTasks.addAll([
      PatientTaskModel(title: 'Brush Teeth', isCompleted: false, date: today),
      PatientTaskModel(title: 'Have Breakfast', isCompleted: false, date: today),
      PatientTaskModel(title: 'Take Medications', isCompleted: false, date: today),
      PatientTaskModel(title: 'Morning Walk', isCompleted: false, date: today),
      PatientTaskModel(title: 'Read a Book', isCompleted: false, date: today),
    ]);

    final yesterday = today.subtract(const Duration(days: 1));
    _allTasks.addAll([
      PatientTaskModel(title: 'Morning Stretching', isCompleted: true, date: yesterday),
      PatientTaskModel(title: 'Language Exercise', isCompleted: true, date: yesterday),
      PatientTaskModel(title: 'Memory Game', isCompleted: false, date: yesterday),
    ]);

    final tomorrow = today.add(const Duration(days: 1));
    _allTasks.addAll([
      PatientTaskModel(
          title: 'Speech Therapy Exercise', isCompleted: false, date: tomorrow),
      PatientTaskModel(title: 'Cognitive PatientTaskModel', isCompleted: false, date: tomorrow),
      PatientTaskModel(title: 'Balance Training', isCompleted: false, date: tomorrow),
    ]);
  }

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<PatientTaskModel> get tasks {
    return _allTasks
        .where((task) =>
            task.date.year == _selectedDate.year &&
            task.date.month == _selectedDate.month &&
            task.date.day == _selectedDate.day)
        .toList();
  }

  void toggleTaskCompletion(int index, bool isCompleted) {
    final tasksForDay = tasks;
    if (index >= 0 && index < tasksForDay.length) {
      final taskIndex = _allTasks.indexOf(tasksForDay[index]);
      if (taskIndex != -1) {
        // Create a new PatientTaskModel with updated completion status
        final oldTask = _allTasks[taskIndex];
        _allTasks[taskIndex] = PatientTaskModel(
          title: oldTask.title,
          isCompleted: isCompleted,
          date: oldTask.date,
        );
        notifyListeners();
      }
    }
  }

  int get completedTasksCount => tasks.where((task) => task.isCompleted).length;
  int get totalTasksCount => tasks.length;
}
