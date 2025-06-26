// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'therapist_patient_details_model.dart';

class TherapistPatientDetailsModelMapper
    extends ClassMapperBase<TherapistPatientDetailsModel> {
  TherapistPatientDetailsModelMapper._();

  static TherapistPatientDetailsModelMapper? _instance;
  static TherapistPatientDetailsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = TherapistPatientDetailsModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TherapistPatientDetailsModel';

  static String _$patientId(TherapistPatientDetailsModel v) => v.patientId;
  static const Field<TherapistPatientDetailsModel, String> _f$patientId =
      Field('patientId', _$patientId, key: r'id');
  static String _$patientName(TherapistPatientDetailsModel v) => v.patientName;
  static const Field<TherapistPatientDetailsModel, String> _f$patientName =
      Field('patientName', _$patientName, key: r'patient_name');
  static String _$phoneNo(TherapistPatientDetailsModel v) => v.phoneNo;
  static const Field<TherapistPatientDetailsModel, String> _f$phoneNo =
      Field('phoneNo', _$phoneNo, key: r'phone');
  static String _$email(TherapistPatientDetailsModel v) => v.email;
  static const Field<TherapistPatientDetailsModel, String> _f$email =
      Field('email', _$email);

  @override
  final MappableFields<TherapistPatientDetailsModel> fields = const {
    #patientId: _f$patientId,
    #patientName: _f$patientName,
    #phoneNo: _f$phoneNo,
    #email: _f$email,
  };

  static TherapistPatientDetailsModel _instantiate(DecodingData data) {
    return TherapistPatientDetailsModel(
        patientId: data.dec(_f$patientId),
        patientName: data.dec(_f$patientName),
        phoneNo: data.dec(_f$phoneNo),
        email: data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static TherapistPatientDetailsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TherapistPatientDetailsModel>(map);
  }

  static TherapistPatientDetailsModel fromJson(String json) {
    return ensureInitialized().decodeJson<TherapistPatientDetailsModel>(json);
  }
}

mixin TherapistPatientDetailsModelMappable {
  String toJson() {
    return TherapistPatientDetailsModelMapper.ensureInitialized()
        .encodeJson<TherapistPatientDetailsModel>(
            this as TherapistPatientDetailsModel);
  }

  Map<String, dynamic> toMap() {
    return TherapistPatientDetailsModelMapper.ensureInitialized()
        .encodeMap<TherapistPatientDetailsModel>(
            this as TherapistPatientDetailsModel);
  }

  TherapistPatientDetailsModelCopyWith<TherapistPatientDetailsModel,
          TherapistPatientDetailsModel, TherapistPatientDetailsModel>
      get copyWith => _TherapistPatientDetailsModelCopyWithImpl<
              TherapistPatientDetailsModel, TherapistPatientDetailsModel>(
          this as TherapistPatientDetailsModel, $identity, $identity);
  @override
  String toString() {
    return TherapistPatientDetailsModelMapper.ensureInitialized()
        .stringifyValue(this as TherapistPatientDetailsModel);
  }

  @override
  bool operator ==(Object other) {
    return TherapistPatientDetailsModelMapper.ensureInitialized()
        .equalsValue(this as TherapistPatientDetailsModel, other);
  }

  @override
  int get hashCode {
    return TherapistPatientDetailsModelMapper.ensureInitialized()
        .hashValue(this as TherapistPatientDetailsModel);
  }
}

extension TherapistPatientDetailsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TherapistPatientDetailsModel, $Out> {
  TherapistPatientDetailsModelCopyWith<$R, TherapistPatientDetailsModel, $Out>
      get $asTherapistPatientDetailsModel => $base.as((v, t, t2) =>
          _TherapistPatientDetailsModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TherapistPatientDetailsModelCopyWith<
    $R,
    $In extends TherapistPatientDetailsModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? patientId, String? patientName, String? phoneNo, String? email});
  TherapistPatientDetailsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TherapistPatientDetailsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TherapistPatientDetailsModel, $Out>
    implements
        TherapistPatientDetailsModelCopyWith<$R, TherapistPatientDetailsModel,
            $Out> {
  _TherapistPatientDetailsModelCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TherapistPatientDetailsModel> $mapper =
      TherapistPatientDetailsModelMapper.ensureInitialized();
  @override
  $R call(
          {String? patientId,
          String? patientName,
          String? phoneNo,
          String? email}) =>
      $apply(FieldCopyWithData({
        if (patientId != null) #patientId: patientId,
        if (patientName != null) #patientName: patientName,
        if (phoneNo != null) #phoneNo: phoneNo,
        if (email != null) #email: email
      }));
  @override
  TherapistPatientDetailsModel $make(CopyWithData data) =>
      TherapistPatientDetailsModel(
          patientId: data.get(#patientId, or: $value.patientId),
          patientName: data.get(#patientName, or: $value.patientName),
          phoneNo: data.get(#phoneNo, or: $value.phoneNo),
          email: data.get(#email, or: $value.email));

  @override
  TherapistPatientDetailsModelCopyWith<$R2, TherapistPatientDetailsModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TherapistPatientDetailsModelCopyWithImpl<$R2, $Out2>(
              $value, $cast, t);
}
