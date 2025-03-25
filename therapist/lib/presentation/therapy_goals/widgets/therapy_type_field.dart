import 'package:flutter/material.dart';

class TherapyTypeField extends StatelessWidget {
  const TherapyTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 53,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton(
        items: [],
        onChanged: (value) {},
        hint: const Text(
          'Select Therapy Type',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff121417),
            fontWeight: FontWeight.w500,
          ),
        ),
        underline: const SizedBox.shrink(),
        icon: Image.asset('assets/arrow_down.png'),
        isExpanded: true,
      ),
    );
  }
}