import 'package:flutter/material.dart';
import 'package:therapist/core/core.dart';
import 'package:therapist/model/model.dart';

class TherapyProvider extends ChangeNotifier {

  TherapyProvider({
    required TherapyRepository therapyRepository,
  }) : _therapyRepository = therapyRepository;

  final TherapyRepository _therapyRepository;

  List<TherapyTypeModel> _therapyTypes = [];
  List<TherapyTypeModel> get therapyTypes => _therapyTypes;

  String? _selectedTherapyType;
  String? get selectedTherapyType => _selectedTherapyType;


  void getThearpyType() async {
    final ActionResult result = await _therapyRepository.getTherapyTypes();
    if(result is ActionResultSuccess) {
      _therapyTypes = result.data;
      notifyListeners();
    } else {
      _therapyTypes = [];
      notifyListeners();
    }
  }

  set setSelectedTherapyType(String therapyType) {
    _selectedTherapyType = therapyType;
    notifyListeners();
  }
}