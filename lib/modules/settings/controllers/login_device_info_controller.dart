import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/login_device_info.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/device_info_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginDeviceInfoController extends GetxController {
  static LoginDeviceInfoController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _loginDeviceInfoData = const DeviceInfoResponse().obs;
  final _isLoading = false.obs;
  final List<LoginDeviceInfo> _loginDeviceInfoList = [];

  bool get isLoading => _isLoading.value;

  DeviceInfoResponse? get deviceInfo => _loginDeviceInfoData.value;

  List<LoginDeviceInfo> get loginDeviceInfoList => _loginDeviceInfoList;

  set setLoginDeviceInfoData(DeviceInfoResponse value) =>
      _loginDeviceInfoData.value = value;

  Future<void> _getLoginDeviceInfo() async {
    AppUtility.printLog("Get LoginDeviceInfo Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getDeviceInfo(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setLoginDeviceInfoData = DeviceInfoResponse.fromJson(decodedData);
        _loginDeviceInfoList.clear();
        _loginDeviceInfoList.addAll(_loginDeviceInfoData.value.results!);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get LoginDeviceInfo Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get LoginDeviceInfo Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deleteLoginDeviceInfo(String deviceId) async {
    AppUtility.printLog("Delete LoginDeviceInfo Request");

    var isPresent =
        _loginDeviceInfoList.any((element) => element.deviceId == deviceId);

    if (isPresent == true) {
      var index = _loginDeviceInfoList
          .indexWhere((element) => element.deviceId == deviceId);
      _loginDeviceInfoList.removeAt(index);
      update();
    }

    try {
      final response =
          await _apiProvider.deleteDeviceInfo(_auth.token, deviceId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtility.printLog("Delete LoginDeviceInfo Success");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
          duration: 1,
        );
      } else {
        update();
        AppUtility.printLog("Delete LoginDeviceInfo Error");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      update();
      AppUtility.printLog("Delete LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      //_postList.insert(postIndex, post);
      update();
      AppUtility.printLog("Delete LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      //_postList.insert(postIndex, post);
      update();
      AppUtility.printLog("Delete LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      //_postList.insert(postIndex, post);
      update();
      AppUtility.printLog("Delete LoginDeviceInfo Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getLoginDeviceInfo() async => await _getLoginDeviceInfo();

  Future<void> deleteLoginDeviceInfo(String deviceId) async =>
      await _deleteLoginDeviceInfo(deviceId);
}
