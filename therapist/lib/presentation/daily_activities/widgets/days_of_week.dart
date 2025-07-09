import 'package:flutter/material.dart';

class DaysOfWeek extends StatelessWidget {
  DaysOfWeek({
    super.key,
    required this.dayIndex,
    required this.isSelected,
  });

  final int dayIndex;
  final bool isSelected;

  
  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xffCB6CE6) : Colors.white,
          border: Border.all(
            color:Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            days[dayIndex],
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}