import 'package:flutter/material.dart';
import 'package:therapist/model/therapist_models/therapist_schedule_model.dart';

import '../core/repository/therapist/therapist_repository.dart';
import '../core/result/action_result_success.dart';

class SessionProvider extends ChangeNotifier {
  String _selectedFilter = 'All';
  String get selectedFilter => _selectedFilter;

  SessionProvider({
    required TherapistRepository therapistRepository,
  }) : _therapistRepository = therapistRepository;

  final TherapistRepository _therapistRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  List<TherapistScheduleModel> _sessions = [];
  List<TherapistScheduleModel> get sessions => _sessions;

  int _totalSessions = 0;
  int get totalSessions => _totalSessions;
  int _totalPendingSessions = 0;
  int get totalPendingSessions => _totalPendingSessions;
  int _totalCompletedSessions = 0;
  int get totalCompletedSessions => _totalCompletedSessions;
  int _totalCancelledSessions = 0;
  int get totalCancelledSessions => _totalCancelledSessions;

  Future<void> fetchTherapistSessions() async {
    try {
      _isLoading = true;
      notifyListeners();
      final result = await _therapistRepository.getTherapistSessions();
      if(result is ActionResultSuccess) {
        _sessions = result.data as List<TherapistScheduleModel>;
      }
    } catch(e) {  
      _sessions = [];
      print(e);
    } finally {
      _isLoading = false;
      _calculateSessionCounts();
      notifyListeners();
    }
  }

  void _calculateSessionCounts() {
    _totalSessions = _sessions.length;
    _totalPendingSessions = _sessions.where((session) => (session.status ?? '').toLowerCase() == 'pending').length;
    _totalCompletedSessions = _sessions.where((session) => (session.status ?? '').toLowerCase() == 'completed').length;
    _totalCancelledSessions = _sessions.where((session) => (session.status ?? '').toLowerCase() == 'cancelled').length;
  }

  List<TherapistScheduleModel> get filteredSessions {
    if (_selectedFilter == 'All') {
      return _sessions;
    } else {
      return _sessions.where((session) => (session.status ?? '').toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
  }

  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  // Methods to add, update, or delete sessions
  void addSession(TherapistScheduleModel session) {
    _sessions.add(session);
    notifyListeners();
  }

  void updateSession(int index, TherapistScheduleModel updatedSession) {
    if (index >= 0 && index < _sessions.length) {
      _sessions[index] = updatedSession;
      notifyListeners();
    }
  }

  void deleteSession(int index) {
    if (index >= 0 && index < _sessions.length) {
      _sessions.removeAt(index);
      notifyListeners();
    }
  }


  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

