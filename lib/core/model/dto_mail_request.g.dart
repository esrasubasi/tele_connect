// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_mail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOMailRequest _$DTOMailRequestFromJson(Map<String, dynamic> json) =>
    DTOMailRequest(
      to: (json['to'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cc: (json['cc'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bcc: (json['bcc'] as List<dynamic>?)?.map((e) => e as String).toList(),
      subject: json['subject'] as String?,
      body: json['body'] as String?,
      contentType: json['contentType'] as String?,
    );

Map<String, dynamic> _$DTOMailRequestToJson(DTOMailRequest instance) =>
    <String, dynamic>{
      'to': instance.to,
      'cc': instance.cc,
      'bcc': instance.bcc,
      'subject': instance.subject,
      'body': instance.body,
      'contentType': instance.contentType,
    };
