import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final bool isLogout;

  const ProfileOption({super.key, required this.title, this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isLogout ? Colors.red : Colors.black,
              fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
          onTap: () {},
        ),
        if (!isLogout)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 2, thickness: 1),
          ),
      ],
    );
  }
}
