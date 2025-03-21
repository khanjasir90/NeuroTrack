import 'package:flutter/material.dart';

// Vertical layout card (for Completed)
class CompletedMilestoneCard extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Color backgroundColor;
  final String value;
  final String label;

  const CompletedMilestoneCard({
    required this.iconPath,
    required this.iconColor,
    required this.backgroundColor,
    required this.value,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196, // Fixed height to match combined height of other cards
      width: MediaQuery.of(context).size.width * 0.4, // Fixed width
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
            ),
            child: ImageIcon(
              AssetImage(
                iconPath,
              ),
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// Horizontal layout card (for Missed and Regressed)
class HorizontalMilestoneCard extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Color backgroundColor;
  final String value;
  final String label;

  const HorizontalMilestoneCard({
    required this.iconPath,
    required this.iconColor,
    required this.backgroundColor,
    required this.value,
    required this.label,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 90, // Fixed height
      width: MediaQuery.of(context).size.width * 0.47, // Fixed width

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
            ),
            child: ImageIcon(
              AssetImage(
                iconPath,
              ),
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22, // Slightly smaller for horizontal layout
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
