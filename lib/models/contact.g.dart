// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactFromJson(Map<String, dynamic> json) {
  return ContactModel(
    id: json['id'] as String,
    firstName: json['firstname'] as String,
    lastName: json['lastname'] as String,
    phoneNr: json['phoneNr'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$ContactToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstName,
      'lastname': instance.lastName,
      'phoneNr': instance.phoneNr,
      'email': instance.email,
    };
