import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/dto_mail_request.dart';

class Api {
  Future sendEmail(DTOMailRequest data) async {
    try {
      Dio dio = Dio();

      dio.options = BaseOptions(
        headers: {
          "Connection": "keep-alive",
          "Content-Type": "application/json",
        },
        baseUrl: "http://172.16.11.95/",
        queryParameters: data.toJson(),
      );

      Response response = await dio.post(
        "MailApi/api/mail",
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        print("başarılı");
      }
      return response;
    } catch (e) {
      log("sendEmail error----$e");
    }
  }
}
