import 'dart:convert';
import 'dart:io';

import 'package:localization/localization.dart';

import '../data_model/error_handler_model.dart';
import '../data_services/app_exception.dart';
import '../utils/global_functions.dart';

Future<dynamic> errorHandler(Future multiMethod,bool isShowError, bool needReturn) async {
  try {
    var data = await multiMethod;

    return data;
  } on BadRequestException catch (e) {
    showErrorToast("$e", true);

    // GlobalFunctions.showToast("$e", false);
    return needReturn ? needErrorReturn(e):null;
  } on UnauthorisedException catch (e) {
    showErrorToast("$e", true);
    // GlobalFunctions.showToast("$e", false);
    return needReturn ? needErrorReturn(e):null;
  } on SocketException catch (e) {
    showErrorToast("${e.message}", true);
    // GlobalFunctions.showToast(e.message, false);
    return needReturn ? needErrorReturn(e.message):null;
  } on TokenExpiredException catch (e) {
    print("Data token is :${e}");
  } catch (e) {
    print(e);
    GlobalFunctions.showToast("apiError".i18n(), false);
  }
  return null;
}

dynamic modelErrorHandler(dynamic method) {
  try {
    return method();
  } catch (e) {
    print("${e}");
    GlobalFunctions.showToast("modelError".i18n(["$e"]), false);
    rethrow;
    // return null;
  }
}

showErrorToast(dynamic message,bool hasShowToast){
  hasShowToast? GlobalFunctions.showToast("$message", false):null;
}

needErrorReturn(dynamic errorMessage){
  ErrorHandlerModel errorHandlerModel=ErrorHandlerModel(success: false, message: errorMessage);
  return errorHandlerModel;
}
