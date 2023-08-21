import 'package:json_annotation/json_annotation.dart';

part 'dto_mail_request.g.dart';

@JsonSerializable()
class DTOMailRequest {
  List<String>? to;
  List<String>? cc;
  List<String>? bcc;
  String? subject;
  String? body;
  String? contentType;

  DTOMailRequest({
    this.to,
    this.cc,
    this.bcc,
    this.subject,
    this.body,
    this.contentType,
  });

  factory DTOMailRequest.fromJson(Map<String, dynamic> json) => _$DTOMailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DTOMailRequestToJson(this);
  fromJson(Map<String, dynamic> json) {
    return _$DTOMailRequestFromJson(json);
  }
}
