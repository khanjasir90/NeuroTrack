import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:therapist/core/entities/consultation/consultation_request_entity.dart';
import 'package:therapist/core/repository/consultation/consultation_repository.dart';
import 'package:therapist/core/result/result.dart';

class SupabaseConsultationRepository implements ConsultationRepository {
  // Make the parameter optional with "?"
  final SupabaseClient? _supabaseClient;
  
  // Accept nullable client
  SupabaseConsultationRepository({
    SupabaseClient? supabaseClient,
  }) : _supabaseClient = supabaseClient;
  
  // Mock data to use until Supabase is ready
  final List<ConsultationRequestEntity> _mockRequests = [
    ConsultationRequestEntity(
      id: '1',
      patientId: 'p1',
      patientName: 'John Doe',
      therapistId: 't1',
      requestDate: DateTime.now().subtract(const Duration(days: 2)),
      proposedTimes: [
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 2)),
        DateTime.now().add(const Duration(days: 3)),
      ],
      assessmentId: 'a1',
      assessmentType: 'Depression Assessment',
      assessmentSummary: 'Patient shows mild signs of depression with PHQ-9 score of 8.',
      status: 'pending',
      notes: 'I would like to discuss my recent assessment results and get your professional opinion.',
    ),
    ConsultationRequestEntity(
      id: '2',
      patientId: 'p2',
      patientName: 'Jane Smith',
      therapistId: 't1',
      requestDate: DateTime.now().subtract(const Duration(days: 5)),
      proposedTimes: [
        DateTime.now().add(const Duration(days: 2, hours: 3)),
        DateTime.now().add(const Duration(days: 4, hours: 1)),
      ],
      assessmentId: 'a2',
      assessmentType: 'Anxiety Assessment',
      assessmentSummary: 'Patient exhibits moderate anxiety symptoms with GAD-7 score of 12.',
      status: 'accepted',
      scheduledTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      notes: 'Looking forward to discussing strategies for managing my anxiety.',
    ),
    ConsultationRequestEntity(
      id: '3',
      patientId: 'p3',
      patientName: 'Robert Johnson',
      therapistId: 't1',
      requestDate: DateTime.now().subtract(const Duration(days: 7)),
      proposedTimes: [
        DateTime.now().subtract(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 1, hours: 2)),
      ],
      assessmentId: 'a3',
      assessmentType: 'Stress Assessment',
      assessmentSummary: 'Patient is experiencing high levels of stress due to work-related factors.',
      status: 'declined',
      notes: 'I need help managing my work-related stress that has been affecting my sleep.',
    ),
  ];

  @override
  Future<ActionResult> fetchConsultationRequests() async {
    try {
      // In a real app, this would fetch from Supabase
      // Example:
      // final response = await _supabaseClient
      //     .from('consultation_requests')
      //     .select()
      //     .eq('therapist_id', _supabaseClient.auth.currentUser?.id)
      //     .execute();
      
      // For now, use mock data
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      
      return ActionResultSuccess(data: _mockRequests, statusCode: 200);
    } catch (e) {
      return ActionResultFailure(errorMessage: e.toString(), statusCode: 400);
    }
  }

  @override
  Future<ActionResult> getConsultationRequestById(String requestId) async {
    try {
      // In a real app, this would fetch from Supabase
      // Example:
      // final response = await _supabaseClient
      //     .from('consultation_requests')
      //     .select()
      //     .eq('id', requestId)
      //     .single()
      //     .execute();
      
      // For now, use mock data
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      
      final request = _mockRequests.firstWhere(
        (req) => req.id == requestId,
        orElse: () => throw Exception('Consultation request not found'),
      );
      
      return ActionResultSuccess(data: request, statusCode: 200);
    } catch (e) {
      return ActionResultFailure(errorMessage: e.toString(), statusCode: 400);
    }
  }

  @override
  Future<ActionResult> updateRequestStatus({
    required String requestId,
    required String status,
    DateTime? scheduledTime,
    String? notes,
  }) async {
    try {
      // In a real app, this would update in Supabase
      // Example:
      // await _supabaseClient
      //     .from('consultation_requests')
      //     .update({
      //       'status': status,
      //       'scheduled_time': scheduledTime?.toIso8601String(),
      //       'notes': notes,
      //       'last_updated': DateTime.now().toIso8601String(),
      //     })
      //     .eq('id', requestId)
      //     .execute();
      
      // For now, update mock data
      await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay
      
      final index = _mockRequests.indexWhere((req) => req.id == requestId);
      if (index != -1) {
        final request = _mockRequests[index];
        _mockRequests[index] = request.$copyWith(
          status: status,
          scheduledTime: scheduledTime,
          notes: notes ?? request.notes,
          lastUpdated: DateTime.now(),
        );
      } else {
        throw Exception('Consultation request not found');
      }
      
      return ActionResultSuccess(
        data: 'Consultation request status updated successfully', 
        statusCode: 200
      );
    } catch (e) {
      return ActionResultFailure(
        errorMessage: 'Failed to update request status: ${e.toString()}',
        statusCode: 400
      );
    }
  }
}