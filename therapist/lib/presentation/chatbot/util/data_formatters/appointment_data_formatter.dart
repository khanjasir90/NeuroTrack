

import 'package:therapist/model/therapist_models/therapist_schedule_model.dart';

import 'generic_data_formatter.dart';

class AppointmentDataFormatter extends GenericDataFormatter<TherapistScheduleModel> {

  @override
  String formatResponse(List<TherapistScheduleModel> items) {
    if (items.isEmpty) {
      return '🗓️✨ No appointments found';
    }

    return '🗓️✨ Here are your appointments:\n\n${items.map((appointment) => '${appointment.therapyName} - ${appointment.timestamp.toString().split(' ').first} - ${appointment.mode}').join('\n')}\n\n🎉 Enjoy your sessions!';
  }

}