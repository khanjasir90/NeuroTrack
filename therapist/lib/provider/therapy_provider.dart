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

  String _getTherapyIdFromSelectedTherapy() {
    final therapyType = _therapyTypes.firstWhere((element) => element.name == _selectedTherapyType);
    return therapyType.therapyId;
  }

  void addTherapyGoals(String goal) async {
    final therapyId = _getTherapyIdFromSelectedTherapy();
    await _therapyRepository.addTherapyGoals(therapyId,goal);
    notifyListeners();
  }

  void addTherapyObservations(String observation) async {
    final therapyId = _getTherapyIdFromSelectedTherapy();
    await _therapyRepository.addTherapyObservations(therapyId, observation);
    notifyListeners();
  }

  void addTherapyRegressions(String regression) async {
    final therapyId = _getTherapyIdFromSelectedTherapy();
    await _therapyRepository.addTherapyRegressions(therapyId, regression);
  }

  void addTherapyActivities(String activity) async {
    final therapyId = _getTherapyIdFromSelectedTherapy();
    await _therapyRepository.addTherapyActivities(therapyId, activity);
  }

}