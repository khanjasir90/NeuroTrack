import 'package:flutter/material.dart';

class DaysOfWeek extends StatelessWidget {
  DaysOfWeek({
    super.key,
    required this.dayIndex,
  });

  final int dayIndex;

  
  final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

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
          color: Colors.white,
          border: Border.all(
            color:Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            days[dayIndex],
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}