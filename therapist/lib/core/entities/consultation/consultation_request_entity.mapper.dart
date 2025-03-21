// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'consultation_request_entity.dart';

class ConsultationRequestEntityMapper
    extends ClassMapperBase<ConsultationRequestEntity> {
  ConsultationRequestEntityMapper._();

  static ConsultationRequestEntityMapper? _instance;
  static ConsultationRequestEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = ConsultationRequestEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ConsultationRequestEntity';

  static String _$id(ConsultationRequestEntity v) => v.id;
  static const Field<ConsultationRequestEntity, String> _f$id =
      Field('id', _$id);
  static String _$patientId(ConsultationRequestEntity v) => v.patientId;
  static const Field<ConsultationRequestEntity, String> _f$patientId =
      Field('patientId', _$patientId);
  static String _$patientName(ConsultationRequestEntity v) => v.patientName;
  static const Field<ConsultationRequestEntity, String> _f$patientName =
      Field('patientName', _$patientName);
  static String? _$patientProfileImageUrl(ConsultationRequestEntity v) =>
      v.patientProfileImageUrl;
  static const Field<ConsultationRequestEntity, String>
      _f$patientProfileImageUrl =
      Field('patientProfileImageUrl', _$patientProfileImageUrl, opt: true);
  static String _$therapistId(ConsultationRequestEntity v) => v.therapistId;
  static const Field<ConsultationRequestEntity, String> _f$therapistId =
      Field('therapistId', _$therapistId);
  static DateTime _$requestDate(ConsultationRequestEntity v) => v.requestDate;
  static const Field<ConsultationRequestEntity, DateTime> _f$requestDate =
      Field('requestDate', _$requestDate);
  static List<DateTime> _$proposedTimes(ConsultationRequestEntity v) =>
      v.proposedTimes;
  static const Field<ConsultationRequestEntity, List<DateTime>>
      _f$proposedTimes = Field('proposedTimes', _$proposedTimes);
  static String _$assessmentId(ConsultationRequestEntity v) => v.assessmentId;
  static const Field<ConsultationRequestEntity, String> _f$assessmentId =
      Field('assessmentId', _$assessmentId);
  static String _$assessmentType(ConsultationRequestEntity v) =>
      v.assessmentType;
  static const Field<ConsultationRequestEntity, String> _f$assessmentType =
      Field('assessmentType', _$assessmentType);
  static String _$assessmentSummary(ConsultationRequestEntity v) =>
      v.assessmentSummary;
  static const Field<ConsultationRequestEntity, String> _f$assessmentSummary =
      Field('assessmentSummary', _$assessmentSummary);
  static String _$status(ConsultationRequestEntity v) => v.status;
  static const Field<ConsultationRequestEntity, String> _f$status =
      Field('status', _$status);
  static DateTime? _$scheduledTime(ConsultationRequestEntity v) =>
      v.scheduledTime;
  static const Field<ConsultationRequestEntity, DateTime> _f$scheduledTime =
      Field('scheduledTime', _$scheduledTime, opt: true);
  static String? _$notes(ConsultationRequestEntity v) => v.notes;
  static const Field<ConsultationRequestEntity, String> _f$notes =
      Field('notes', _$notes, opt: true);
  static DateTime? _$lastUpdated(ConsultationRequestEntity v) => v.lastUpdated;
  static const Field<ConsultationRequestEntity, DateTime> _f$lastUpdated =
      Field('lastUpdated', _$lastUpdated, opt: true);

  @override
  final MappableFields<ConsultationRequestEntity> fields = const {
    #id: _f$id,
    #patientId: _f$patientId,
    #patientName: _f$patientName,
    #patientProfileImageUrl: _f$patientProfileImageUrl,
    #therapistId: _f$therapistId,
    #requestDate: _f$requestDate,
    #proposedTimes: _f$proposedTimes,
    #assessmentId: _f$assessmentId,
    #assessmentType: _f$assessmentType,
    #assessmentSummary: _f$assessmentSummary,
    #status: _f$status,
    #scheduledTime: _f$scheduledTime,
    #notes: _f$notes,
    #lastUpdated: _f$lastUpdated,
  };

  static ConsultationRequestEntity _instantiate(DecodingData data) {
    return ConsultationRequestEntity(
        id: data.dec(_f$id),
        patientId: data.dec(_f$patientId),
        patientName: data.dec(_f$patientName),
        patientProfileImageUrl: data.dec(_f$patientProfileImageUrl),
        therapistId: data.dec(_f$therapistId),
        requestDate: data.dec(_f$requestDate),
        proposedTimes: data.dec(_f$proposedTimes),
        assessmentId: data.dec(_f$assessmentId),
        assessmentType: data.dec(_f$assessmentType),
        assessmentSummary: data.dec(_f$assessmentSummary),
        status: data.dec(_f$status),
        scheduledTime: data.dec(_f$scheduledTime),
        notes: data.dec(_f$notes),
        lastUpdated: data.dec(_f$lastUpdated));
  }

  @override
  final Function instantiate = _instantiate;

  static ConsultationRequestEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConsultationRequestEntity>(map);
  }

  static ConsultationRequestEntity fromJson(String json) {
    return ensureInitialized().decodeJson<ConsultationRequestEntity>(json);
  }
}

mixin ConsultationRequestEntityMappable {
  String toJson() {
    return ConsultationRequestEntityMapper.ensureInitialized()
        .encodeJson<ConsultationRequestEntity>(
            this as ConsultationRequestEntity);
  }

  Map<String, dynamic> toMap() {
    return ConsultationRequestEntityMapper.ensureInitialized()
        .encodeMap<ConsultationRequestEntity>(
            this as ConsultationRequestEntity);
  }

  ConsultationRequestEntityCopyWith<ConsultationRequestEntity,
          ConsultationRequestEntity, ConsultationRequestEntity>
      get copyWith => _ConsultationRequestEntityCopyWithImpl(
          this as ConsultationRequestEntity, $identity, $identity);
  @override
  String toString() {
    return ConsultationRequestEntityMapper.ensureInitialized()
        .stringifyValue(this as ConsultationRequestEntity);
  }

  @override
  bool operator ==(Object other) {
    return ConsultationRequestEntityMapper.ensureInitialized()
        .equalsValue(this as ConsultationRequestEntity, other);
  }

  @override
  int get hashCode {
    return ConsultationRequestEntityMapper.ensureInitialized()
        .hashValue(this as ConsultationRequestEntity);
  }
}

extension ConsultationRequestEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConsultationRequestEntity, $Out> {
  ConsultationRequestEntityCopyWith<$R, ConsultationRequestEntity, $Out>
      get $asConsultationRequestEntity => $base
          .as((v, t, t2) => _ConsultationRequestEntityCopyWithImpl(v, t, t2));
}

abstract class ConsultationRequestEntityCopyWith<
    $R,
    $In extends ConsultationRequestEntity,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
      get proposedTimes;
  $R call(
      {String? id,
      String? patientId,
      String? patientName,
      String? patientProfileImageUrl,
      String? therapistId,
      DateTime? requestDate,
      List<DateTime>? proposedTimes,
      String? assessmentId,
      String? assessmentType,
      String? assessmentSummary,
      String? status,
      DateTime? scheduledTime,
      String? notes,
      DateTime? lastUpdated});
  ConsultationRequestEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ConsultationRequestEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConsultationRequestEntity, $Out>
    implements
        ConsultationRequestEntityCopyWith<$R, ConsultationRequestEntity, $Out> {
  _ConsultationRequestEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConsultationRequestEntity> $mapper =
      ConsultationRequestEntityMapper.ensureInitialized();
  @override
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
      get proposedTimes => ListCopyWith(
          $value.proposedTimes,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(proposedTimes: v));
  @override
  $R call(
          {String? id,
          String? patientId,
          String? patientName,
          Object? patientProfileImageUrl = $none,
          String? therapistId,
          DateTime? requestDate,
          List<DateTime>? proposedTimes,
          String? assessmentId,
          String? assessmentType,
          String? assessmentSummary,
          String? status,
          Object? scheduledTime = $none,
          Object? notes = $none,
          Object? lastUpdated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (patientId != null) #patientId: patientId,
        if (patientName != null) #patientName: patientName,
        if (patientProfileImageUrl != $none)
          #patientProfileImageUrl: patientProfileImageUrl,
        if (therapistId != null) #therapistId: therapistId,
        if (requestDate != null) #requestDate: requestDate,
        if (proposedTimes != null) #proposedTimes: proposedTimes,
        if (assessmentId != null) #assessmentId: assessmentId,
        if (assessmentType != null) #assessmentType: assessmentType,
        if (assessmentSummary != null) #assessmentSummary: assessmentSummary,
        if (status != null) #status: status,
        if (scheduledTime != $none) #scheduledTime: scheduledTime,
        if (notes != $none) #notes: notes,
        if (lastUpdated != $none) #lastUpdated: lastUpdated
      }));
  @override
  ConsultationRequestEntity $make(CopyWithData data) =>
      ConsultationRequestEntity(
          id: data.get(#id, or: $value.id),
          patientId: data.get(#patientId, or: $value.patientId),
          patientName: data.get(#patientName, or: $value.patientName),
          patientProfileImageUrl: data.get(#patientProfileImageUrl,
              or: $value.patientProfileImageUrl),
          therapistId: data.get(#therapistId, or: $value.therapistId),
          requestDate: data.get(#requestDate, or: $value.requestDate),
          proposedTimes: data.get(#proposedTimes, or: $value.proposedTimes),
          assessmentId: data.get(#assessmentId, or: $value.assessmentId),
          assessmentType: data.get(#assessmentType, or: $value.assessmentType),
          assessmentSummary:
              data.get(#assessmentSummary, or: $value.assessmentSummary),
          status: data.get(#status, or: $value.status),
          scheduledTime: data.get(#scheduledTime, or: $value.scheduledTime),
          notes: data.get(#notes, or: $value.notes),
          lastUpdated: data.get(#lastUpdated, or: $value.lastUpdated));

  @override
  ConsultationRequestEntityCopyWith<$R2, ConsultationRequestEntity, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ConsultationRequestEntityCopyWithImpl($value, $cast, t);
}
