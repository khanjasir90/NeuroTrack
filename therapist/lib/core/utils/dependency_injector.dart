import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:therapist/core/repository/therapist/therapist_repository.dart';
import 'package:therapist/repository/supabase_therapist_repository.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
  getIt.registerSingleton<TherapistRepository>(SupabaseTherapistRepository(supabaseClient: getIt<SupabaseClient>()));
}