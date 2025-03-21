import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:therapist/core/entities/consultation/consultation_request_entity.dart';


class ConsultationRequestDetailCard extends StatelessWidget {
  final ConsultationRequestEntity request;
  final Function(DateTime) onTimeSelected;
  final int? selectedTimeIndex;

  const ConsultationRequestDetailCard({
    Key? key,
    required this.request,
    required this.onTimeSelected,
    this.selectedTimeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('EEEE, MMM d, yyyy • h:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfo(),
            const Divider(height: 24),
            _buildAssessmentInfo(),
            const Divider(height: 24),
            _buildTimeSlots(dateFormat),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 28,
          child: Text(
            request.patientName[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.patientName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Requested: ${DateFormat('MMM d, yyyy').format(request.requestDate)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssessmentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assessment Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow('Type', request.assessmentType),
        const SizedBox(height: 8),
        _buildInfoRow('Summary', request.assessmentSummary),
      ],
    );
  }

  Widget _buildTimeSlots(DateFormat dateFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Proposed Time Slots',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          request.proposedTimes.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: () => onTimeSelected(request.proposedTimes[index]),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedTimeIndex == index
                        ? Colors.black
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: selectedTimeIndex == index
                      ? Colors.black.withOpacity(0.05)
                      : Colors.white,
                ),
                child: Row(
                  children: [
                    selectedTimeIndex == index
                        ? const Icon(
                            Icons.radio_button_checked,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey,
                          ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        dateFormat.format(request.proposedTimes[index]),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: selectedTimeIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedTimeIndex == index
                              ? Colors.grey[900]
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (request.notes != null && request.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Patient Message',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: Text(
              request.notes!,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}