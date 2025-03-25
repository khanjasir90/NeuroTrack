// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'therapy_goal_model.dart';

class TherapyGoalModelMapper extends ClassMapperBase<TherapyGoalModel> {
  TherapyGoalModelMapper._();

  static TherapyGoalModelMapper? _instance;
  static TherapyGoalModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TherapyGoalModelMapper._());
      TherapyModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TherapyGoalModel';

  static DateTime _$performedOn(TherapyGoalModel v) => v.performedOn;
  static const Field<TherapyGoalModel, DateTime> _f$performedOn =
      Field('performedOn', _$performedOn, key: r'performed_on');
  static String _$therapistId(TherapyGoalModel v) => v.therapistId;
  static const Field<TherapyGoalModel, String> _f$therapistId =
      Field('therapistId', _$therapistId, key: r'therapist_id');
  static String _$therapyId(TherapyGoalModel v) => v.therapyId;
  static const Field<TherapyGoalModel, String> _f$therapyId =
      Field('therapyId', _$therapyId, key: r'therapy_id');
  static List<TherapyModel> _$goals(TherapyGoalModel v) => v.goals;
  static const Field<TherapyGoalModel, List<TherapyModel>> _f$goals =
      Field('goals', _$goals);
  static List<TherapyModel> _$observations(TherapyGoalModel v) =>
      v.observations;
  static const Field<TherapyGoalModel, List<TherapyModel>> _f$observations =
      Field('observations', _$observations);
  static List<TherapyModel> _$regressions(TherapyGoalModel v) => v.regressions;
  static const Field<TherapyGoalModel, List<TherapyModel>> _f$regressions =
      Field('regressions', _$regressions);
  static List<TherapyModel> _$activities(TherapyGoalModel v) => v.activities;
  static const Field<TherapyGoalModel, List<TherapyModel>> _f$activities =
      Field('activities', _$activities);
  static String _$therapyDate(TherapyGoalModel v) => v.therapyDate;
  static const Field<TherapyGoalModel, String> _f$therapyDate =
      Field('therapyDate', _$therapyDate, key: r'therapy_date');

  @override
  final MappableFields<TherapyGoalModel> fields = const {
    #performedOn: _f$performedOn,
    #therapistId: _f$therapistId,
    #therapyId: _f$therapyId,
    #goals: _f$goals,
    #observations: _f$observations,
    #regressions: _f$regressions,
    #activities: _f$activities,
    #therapyDate: _f$therapyDate,
  };

  static TherapyGoalModel _instantiate(DecodingData data) {
    return TherapyGoalModel(
        performedOn: data.dec(_f$performedOn),
        therapistId: data.dec(_f$therapistId),
        therapyId: data.dec(_f$therapyId),
        goals: data.dec(_f$goals),
        observations: data.dec(_f$observations),
        regressions: data.dec(_f$regressions),
        activities: data.dec(_f$activities),
        therapyDate: data.dec(_f$therapyDate));
  }

  @override
  final Function instantiate = _instantiate;

  static TherapyGoalModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TherapyGoalModel>(map);
  }

  static TherapyGoalModel fromJson(String json) {
    return ensureInitialized().decodeJson<TherapyGoalModel>(json);
  }
}

mixin TherapyGoalModelMappable {
  String toJson() {
    return TherapyGoalModelMapper.ensureInitialized()
        .encodeJson<TherapyGoalModel>(this as TherapyGoalModel);
  }

  Map<String, dynamic> toMap() {
    return TherapyGoalModelMapper.ensureInitialized()
        .encodeMap<TherapyGoalModel>(this as TherapyGoalModel);
  }

  TherapyGoalModelCopyWith<TherapyGoalModel, TherapyGoalModel, TherapyGoalModel>
      get copyWith => _TherapyGoalModelCopyWithImpl(
          this as TherapyGoalModel, $identity, $identity);
  @override
  String toString() {
    return TherapyGoalModelMapper.ensureInitialized()
        .stringifyValue(this as TherapyGoalModel);
  }

  @override
  bool operator ==(Object other) {
    return TherapyGoalModelMapper.ensureInitialized()
        .equalsValue(this as TherapyGoalModel, other);
  }

  @override
  int get hashCode {
    return TherapyGoalModelMapper.ensureInitialized()
        .hashValue(this as TherapyGoalModel);
  }
}

extension TherapyGoalModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TherapyGoalModel, $Out> {
  TherapyGoalModelCopyWith<$R, TherapyGoalModel, $Out>
      get $asTherapyGoalModel =>
          $base.as((v, t, t2) => _TherapyGoalModelCopyWithImpl(v, t, t2));
}

abstract class TherapyGoalModelCopyWith<$R, $In extends TherapyGoalModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TherapyModel,
      TherapyModelCopyWith<$R, TherapyModel, TherapyModel>> get goals;
  ListCopyWith<$R, TherapyModel,
      TherapyModelCopyWith<$R, TherapyModel, TherapyModel>> get observations;
  ListCopyWith<$R, TherapyModel,
      TherapyModelCopyWith<$R, TherapyModel, TherapyModel>> get regressions;
  ListCopyWith<$R, TherapyModel,
      TherapyModelCopyWith<$R, TherapyModel, TherapyModel>> get activities;
  $R call(
      {DateTime? performedOn,
      String? therapistId,
      String? therapyId,
      List<TherapyModel>? goals,
      List<TherapyModel>? observations,
      List<TherapyModel>? regressions,
      List<TherapyModel>? activities,
      String? therapyDate});
  TherapyGoalModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TherapyGoalModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TherapyGoalModel, $Out>
    implements TherapyGoalModelCopyWith<$R, TherapyGoalModel, $Out> {
  _TherapyGoalModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TherapyGoalModel> $mapper =
      TherapyGoalModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TherapyModel,
          TherapyModelCopyWith<$R, TherapyModel, TherapyModel>>
      get goals => ListCopyWith(
          $value.goals, (v, t) => v.copyWith.$chain(t), (v) => call(goals: v));
  @override
  ListCopyWith<$R, TherapyModel,
          TherapyModelCopyWith<$R, TherapyModel, TherapyModel>>
      get observations => ListCopyWith($value.observations,
          (v, t) => v.copyWith.$chain(t), (v) => call(observations: v));
  @override
  ListCopyWith<$R, TherapyModel,
          TherapyModelCopyWith<$R, TherapyModel, TherapyModel>>
      get regressions => ListCopyWith($value.regressions,
          (v, t) => v.copyWith.$chain(t), (v) => call(regressions: v));
  @override
  ListCopyWith<$R, TherapyModel,
          TherapyModelCopyWith<$R, TherapyModel, TherapyModel>>
      get activities => ListCopyWith($value.activities,
          (v, t) => v.copyWith.$chain(t), (v) => call(activities: v));
  @override
  $R call(
          {DateTime? performedOn,
          String? therapistId,
          String? therapyId,
          List<TherapyModel>? goals,
          List<TherapyModel>? observations,
          List<TherapyModel>? regressions,
          List<TherapyModel>? activities,
          String? therapyDate}) =>
      $apply(FieldCopyWithData({
        if (performedOn != null) #performedOn: performedOn,
        if (therapistId != null) #therapistId: therapistId,
        if (therapyId != null) #therapyId: therapyId,
        if (goals != null) #goals: goals,
        if (observations != null) #observations: observations,
        if (regressions != null) #regressions: regressions,
        if (activities != null) #activities: activities,
        if (therapyDate != null) #therapyDate: therapyDate
      }));
  @override
  TherapyGoalModel $make(CopyWithData data) => TherapyGoalModel(
      performedOn: data.get(#performedOn, or: $value.performedOn),
      therapistId: data.get(#therapistId, or: $value.therapistId),
      therapyId: data.get(#therapyId, or: $value.therapyId),
      goals: data.get(#goals, or: $value.goals),
      observations: data.get(#observations, or: $value.observations),
      regressions: data.get(#regressions, or: $value.regressions),
      activities: data.get(#activities, or: $value.activities),
      therapyDate: data.get(#therapyDate, or: $value.therapyDate));

  @override
  TherapyGoalModelCopyWith<$R2, TherapyGoalModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TherapyGoalModelCopyWithImpl($value, $cast, t);
}
