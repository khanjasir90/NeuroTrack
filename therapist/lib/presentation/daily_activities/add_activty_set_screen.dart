import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist/core/common/widgets/primary_button.dart';
import 'package:therapist/presentation/widgets/snackbar_service.dart';
import 'package:uuid/uuid.dart';

import '../../core/entities/daily_activity_entities/daily_activity_model.dart';
import '../../model/daily_activities/daily_activity_response_model.dart' show DailyActivityResponseModel;
import '../../provider/daily_activities_provider.dart';

class AddActivitySetScreen extends StatefulWidget {
  const AddActivitySetScreen({
    super.key,
    required this.patientId,
    this.activitySetId,
    this.activityName,
    this.activities,
    this.selectedWeekdays,
    this.startDate,
    this.endDate,
    required this.onSave,
  });
  final String patientId;
  final String? activitySetId;
  final String? activityName;
  final List<String>? activities;
  final List<String>? selectedWeekdays;
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onSave;

  @override
  State<AddActivitySetScreen> createState() => _AddActivitySetScreenState();
}

class _AddActivitySetScreenState extends State<AddActivitySetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _activitySetNameController = TextEditingController();
  final _activityController = TextEditingController();
  
  List<String> activities = [];
  List<String> selectedWeekdays = [];
  DateTime? startDate;
  DateTime? endDate;
  
  final List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday', 
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.activityName != null) {
      _activitySetNameController.text = widget.activityName!;
    }
    if (widget.activities != null) {
      activities = widget.activities!;
    }
    if (widget.selectedWeekdays != null) {
      selectedWeekdays = widget.selectedWeekdays!;
    }
    if (widget.startDate != null) {
      startDate = widget.startDate;
    }
    if (widget.endDate != null) {
      endDate = widget.endDate;
    }
  }

  void _saveActivitySet() {
    final activitySet = DailyActivityResponseModel(
      id: widget.activitySetId ?? '',
      createdAt: DateTime.now().toIso8601String(),
      activityName: _activitySetNameController.text,
      activityList: activities.map((e) => DailyActivityModel(id: const Uuid().v4(), activity: e, isCompleted: false)).toList(),
      isActive: true,
      patientId: widget.patientId,
      therapistId: '',
      startTime: startDate?.toIso8601String() ?? '',
      endTime: endDate?.toIso8601String() ?? '',
      daysOfWeek: (() {
        final days = <String>[];
        for(int i = 0; i < 7; i++) {
          if(selectedWeekdays.contains(weekdays[i])) {
            days.add(i.toString());
          }
        }
        return days;
      })(),
    );
    context.read<DailyActivitiesProvider>().addOrUpdateActivitySet(activitySet);
  }

  @override
  void dispose() {
    _activitySetNameController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  void _addActivity() {
    if (_activityController.text.trim().isNotEmpty) {
      setState(() {
        activities.add(_activityController.text.trim());
        _activityController.clear();
      });
    }
  }

  void _removeActivity(int index) {
    setState(() {
      activities.removeAt(index);
    });
  }

  void _toggleWeekday(String weekday) {
    setState(() {
      if (selectedWeekdays.contains(weekday)) {
        selectedWeekdays.remove(weekday);
      } else {
        selectedWeekdays.add(weekday);
      }
    });
  }

  void _validateActivitySet() {
    if (_formKey.currentState!.validate() &&
        activities.isNotEmpty &&
        selectedWeekdays.isNotEmpty &&
        startDate != null &&
        endDate != null &&
        !endDate!.isBefore(startDate!)) {
      _saveActivitySet();
      Future.delayed(const Duration(milliseconds: 200), () {
        widget.onSave();
      });
      Navigator.pop(context);
    } else {
      String errorMsg = 'Please fill all required fields';
      if (startDate == null || endDate == null) {
        errorMsg = 'Please select both start and end dates';
      } else if (endDate != null && startDate != null && endDate!.isBefore(startDate!)) {
        errorMsg = 'End date cannot be before start date';
      }

      SnackbarService.showError(errorMsg);
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Activity Set',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Create New Activity Set',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Set up activities for your patient',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(92, 93, 103, 1),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Activity Set Name
                _buildTextField(
                  fieldName: 'activitySetName',
                  label: 'Activity Set Name',
                  controller: _activitySetNameController,
                  hintText: 'Enter activity set name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter activity set name';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                // Activities Section
                _buildActivitiesSection(),
                const SizedBox(height: 24),
                
                // Weekdays Selection
                _buildWeekdaysSection(),
                const SizedBox(height: 24),
                
                // Date Picker Section
                _buildDatePickerSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: PrimaryButton(text: 'Save Activity Set', onPressed: _validateActivitySet),
      ),
    );
  }

  Widget _buildActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '  Activities',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        
        // Add Activity Input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _activityController,
                decoration: InputDecoration(
                  hintText: 'Enter activity name',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            PrimaryButton(text: 'Add', onPressed: _addActivity),
          ],
        ),
        
        // Activities List
        if (activities.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(activities[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeActivity(index),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWeekdaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '  Select Weekdays',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: weekdays.map((weekday) {
            final isSelected = selectedWeekdays.contains(weekday);
            return GestureDetector(
              onTap: () => _toggleWeekday(weekday),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffCB6CE6) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xffCB6CE6) : Colors.grey.shade400,
                  ),
                ),
                child: Text(
                  weekday,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '  Select Start and End Date',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: startDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      startDate = picked;
                      // If endDate is before new startDate, reset endDate
                      if (endDate != null && endDate!.isBefore(startDate!)) {
                        endDate = null;
                      }
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    startDate != null
                        ? 'Start: ${_formatDate(startDate!)}'
                        : 'Select Start Date',
                    style: TextStyle(
                      color: startDate != null ? Colors.black : Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: endDate ?? (startDate ?? DateTime.now()),
                    firstDate: startDate ?? DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      endDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    endDate != null
                        ? 'End: ${_formatDate(endDate!)}'
                        : 'Select End Date',
                    style: TextStyle(
                      color: endDate != null ? Colors.black : Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Widget _buildTextField({
    required String fieldName,
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '  $label',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}