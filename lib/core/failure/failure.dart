import 'dart:io';

import 'package:dio/dio.dart';

abstract class Failure {
  final String messageError;
  Failure(this.messageError);
}

class ApiFailure extends Failure {
  ApiFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.messageError);

  //from Server Failure
  factory ServerFailure.fromServerFailure(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure("connection Time out");
      case DioErrorType.sendTimeout:
        return ServerFailure("send Time out");

      case DioErrorType.receiveTimeout:
        return ServerFailure("receive Time out");

      case DioErrorType.badCertificate:
        return ServerFailure("bad Certificate");
      case DioErrorType.badResponse:
        return ServerFailure.fromResponsive(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioErrorType.cancel:
        return ServerFailure("cancel");
      case DioErrorType.connectionError:
        return ServerFailure("there is no internet connection");
      case DioErrorType.unknown:
        if (dioError is SocketException) {
          return ServerFailure("Socket Exception");
        }
        return ServerFailure("unknown Error");
      default:
        return ServerFailure("ops there is an error,please try again");
    }
  }

  factory ServerFailure.fromResponsive(int statusCode, dynamic data) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure("your  responsive error message");
    } else if (statusCode == 403) {
      return ServerFailure("not found");
    } else if (statusCode == 500) {
      return ServerFailure("Internal server error");
    } else {
      return ServerFailure("ops there is an error,please try again");
    }
  }
}
