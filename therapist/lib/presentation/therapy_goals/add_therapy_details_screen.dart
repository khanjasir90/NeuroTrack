import 'package:flutter/material.dart';
import 'package:therapist/core/theme/theme.dart';

class AddTherapyDetailsScreen extends StatelessWidget {
  const AddTherapyDetailsScreen({
    super.key,
    required this.title,
  });

  final String title;

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/arrow_left.png',
           width: 24,
           height: 24,
          ),
        ),
        title:  Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          spacing: 2,
          children: [
            _BuildOptionTile(),
            _BuildOptionTile(),
            _BuildOptionTile(),
            _BuildOptionTile(),
            _BuildOptionTile(),
          ],
        ),
      ),
    );
  }
}

class _BuildOptionTile extends StatelessWidget {
  const _BuildOptionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: AppTheme.primaryColor,
            value: true,
            onChanged: (value) {}),
        const Text('Brush Teeth'),
      ],
    );
  }
}