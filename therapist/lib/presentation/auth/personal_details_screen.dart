import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/common/chips_input_field.dart';
import '../../provider/therapist_provider.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final licenseController = TextEditingController();
  String selectedGender = '';
  List<String> selectedTherapies = [];

  // Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Use the therapist provider
    final therapistDataProvider = Provider.of<TherapistDataProvider>(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: FilledButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // TODO: Call the API
            }
          },
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 74),
                const Text(
                  "Personal Details",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tell us a bit about yourself',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(92, 93, 103, 1)),
                ),
                const SizedBox(height: 42),
                _buildTextField(
                  label: 'Full Name',
                  controller: nameController,
                  hintText: 'What should we call you?',
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Age',
                  controller: ageController,
                  hintText: 'Your Age',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildDropDown(
                    headerText: '  Gender',
                    dropdownItems: [
                      const DropdownMenuEntry(value: 'Male', label: 'Male'),
                      const DropdownMenuEntry(value: 'Female', label: 'Female'),
                      const DropdownMenuEntry(value: 'Others', label: 'Others'),
                    ],
                    onSelected: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    }),
                const SizedBox(height: 20),
                _buildDropDown(
                  headerText: '  Specialization',
                  dropdownItems:
                      therapistDataProvider.specializationDropdownItems,
                ),
                const SizedBox(height: 20),
                _buildDropDown(
                  headerText: '  Regulatory Body',
                  dropdownItems:
                      therapistDataProvider.regulatoryBodyDropdownItems,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Registration/License Number',
                  controller: licenseController,
                  hintText: 'Enter your registration/license number',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your registration/license number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                OfferedTherapiesChoiceChipInput(
                  initialSelected: const [],
                  therapies: therapistDataProvider.therapies,
                  onSelectedTherapiesChanged: (value) {
                    setState(() {
                      selectedTherapies = value;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
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
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.blue,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade600)),
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Column _buildDropDown({
    required String headerText,
    required List<DropdownMenuEntry> dropdownItems,
    void Function(dynamic)? onSelected,
    dynamic initialSelection,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          headerText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        DropdownMenu(
          onSelected: onSelected,
          initialSelection: initialSelection,
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey.shade600,
          ),
          expandedInsets: const EdgeInsets.all(0),
          dropdownMenuEntries: dropdownItems,
        ),
      ],
    );
  }
}
