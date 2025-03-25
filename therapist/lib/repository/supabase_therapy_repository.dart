import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:therapist/core/result/result.dart';
import 'package:therapist/model/therapy_models/therapy_models.dart';

import '../core/repository/repository.dart';

class SupabaseTherapyRepository implements TherapyRepository {
  final SupabaseClient _supabaseClient;

  SupabaseTherapyRepository(this._supabaseClient);

  @override
  Future<ActionResult> getTherapyTypes() async {
    try {
      final response = await _supabaseClient.from('therapy_types').select('*');
      final data = response.map((e) => TherapyTypeModelMapper.fromMap(e)).toList();
      return ActionResultSuccess(data: data, statusCode: 200);
    } catch(e) {
      return ActionResultFailure(errorMessage: e.toString(), statusCode: 500);
    }
  }

}