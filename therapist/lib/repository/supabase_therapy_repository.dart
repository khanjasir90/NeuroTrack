import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:therapist/core/entities/therapy_entities/therapy_type_entity.dart';
import 'package:therapist/core/result/result.dart';

import '../core/repository/repository.dart';

class SupabaseTherapyRepository implements TherapyRepository {
 final _supabaseClient = Supabase.instance.client;

  @override
  Future<ActionResult> getTherapyTypes() async {
    try {
      final response = await _supabaseClient.from('therapy_type').select('*');
      final data = response.map((e) => TherapyTypeEntityMapper.fromMap(e).toModel()).toList();
      return ActionResultSuccess(data: data, statusCode: 200);
    } catch(e) {
      return ActionResultFailure(errorMessage: e.toString(), statusCode: 500);
    }
  }

}