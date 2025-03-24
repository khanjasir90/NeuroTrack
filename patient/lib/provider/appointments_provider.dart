import 'package:flutter/material.dart';

class AppointmentsProvider extends ChangeNotifier {
  static const List<String> _serviceTypes = [
    'Consultation',
    'Therapy Session',
    'Assessment Evaluation',
  ];
  List<AppointmentModel> _appointments = [];
  String _selectedService = 'Consultation';
  DateTime? _selectedDate;
  String _selectedTimeSlot = '';

  // Getters
  List<String> get serviceTypes => _serviceTypes;
  List<AppointmentModel> get appointments => _appointments;
  String get selectedService => _selectedService;
  DateTime? get selectedDate => _selectedDate;
  String get selectedTimeSlot => _selectedTimeSlot;
  bool get hasAppointments => _appointments.isNotEmpty;

  // Setters with notification
  void setSelectedService(String service) {
    _selectedService = service;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTimeSlot(String timeSlot) {
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  // Create a new appointment and add in supabase as per need
  Future<bool> createAppointment() async {
    if (_selectedService.isEmpty ||
        _selectedDate == null ||
        _selectedTimeSlot.isEmpty) {
      return false;
    }

    final newAppointment = AppointmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      serviceType: _selectedService,
      appointmentDate: _selectedDate!,
      timeSlot: _selectedTimeSlot,
    );

    _appointments.add(newAppointment);

    // Reset selection
    _selectedService = '';
    _selectedDate = null;
    _selectedTimeSlot = '';

    notifyListeners();
    return true;
  }

  void deleteAppointment(String id) {
    print(id);
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }

  // Clear all selections
  void clearSelections() {
    _selectedService = '';
    _selectedDate = null;
    _selectedTimeSlot = '';
    notifyListeners();
  }
}

//dummy/temporary model class for appointment
// This should be replaced with the actual model class used in the app
class AppointmentModel {
  final String id;
  final String serviceType;
  final DateTime appointmentDate;
  final String timeSlot;
  final bool isCompleted;

  AppointmentModel({
    required this.id,
    required this.serviceType,
    required this.appointmentDate,
    required this.timeSlot,
    this.isCompleted = false,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      serviceType: json['serviceType'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      timeSlot: json['timeSlot'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceType': serviceType,
      'appointmentDate': appointmentDate.toIso8601String(),
      'timeSlot': timeSlot,
      'isCompleted': isCompleted,
    };
  }
}
