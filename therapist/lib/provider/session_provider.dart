import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'All';

  // Example session data (You can replace it with your API data)
  final List<Map<String, dynamic>> _allSessions = [
    {
      'patientName': 'John Doe',
      'patientId': 'P001',
      'phone': '123-456-7890',
      'therapyName': 'Physical Therapy',
      'therapyMode': 'Online',
      'time': '10:00 AM',
      'duration': '45 mins',
      'status': 'Completed',
    },
    {
      'patientName': 'Jane Smith',
      'patientId': 'P002',
      'phone': '987-654-3210',
      'therapyName': 'Speech Therapy',
      'therapyMode': 'In-Person',
      'time': '11:30 AM',
      'duration': '30 mins',
      'status': 'Pending',
    },
    {
      'patientName': 'Emily Johnson',
      'patientId': 'P003',
      'phone': '555-123-4567',
      'therapyName': 'Occupational Therapy',
      'therapyMode': 'Online',
      'time': '2:00 PM',
      'duration': '60 mins',
      'status': 'Confirmed',
    },
    {
      'patientName': 'Michael Brown',
      'patientId': 'P004',
      'phone': '555-765-4321',
      'therapyName': 'Cognitive Therapy',
      'therapyMode': 'In-Person',
      'time': '3:30 PM',
      'duration': '45 mins',
      'status': 'Completed',
    },
  ];

  // Filters for session categories
  final List<String> _filters = ['All', 'Pending', 'Confirmed', 'Completed'];

  // 🔹 Get selected date
  DateTime get selectedDate => _selectedDate;

  // 🔹 Set selected date and notify listeners
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // 🔹 Get selected filter
  String get selectedFilter => _selectedFilter;

  // 🔹 Set selected filter and notify listeners
  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  // 🔹 Get all sessions
  List<Map<String, dynamic>> get allSessions => _allSessions;

  // 🔹 Get filters
  List<String> get filters => _filters;

  // 🔹 Get filtered sessions based on selected filter
  List<Map<String, dynamic>> get filteredSessions {
    if (_selectedFilter == 'All') {
      return _allSessions;
    } else {
      return _allSessions
          .where((session) => session['status'] == _selectedFilter)
          .toList();
    }
  }

  // 🔹 Get count of sessions for each filter
  Map<String, int> get filterCounts {
    Map<String, int> counts = {
      'All': _allSessions.length,
      'Pending': _allSessions.where((s) => s['status'] == 'Pending').length,
      'Confirmed': _allSessions.where((s) => s['status'] == 'Confirmed').length,
      'Completed': _allSessions.where((s) => s['status'] == 'Completed').length,
    };
    return counts;
  }
}
