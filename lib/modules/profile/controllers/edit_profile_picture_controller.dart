import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class EditProfilePictureController extends GetxController {
  static EditProfilePictureController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _pickedImage = Rxn<File>();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  File? get pickedImage => _pickedImage.value;

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.uploadPreset);

  Future<void> chooseImage() async {
    _pickedImage.value = await AppUtils.selectSingleImage();

    if (_pickedImage.value != null) {
      AppUtils.printLog(_pickedImage.value!.path);
      await _uploadProfilePicture();
    }
  }

  Future<void> _uploadProfilePicture() async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);
    AppUtils.printLog("Update Profile Picture Request");

    var filePath = _pickedImage.value!.path;
    var sizeInKb = _pickedImage.value!.sizeToKb();
    if (sizeInKb > 2048) {
      AppUtils.showSnackBar(
        'Image file size must be lower than 2 MB',
        StringValues.warning,
      );
      return;
    }

    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    String? publicId = '';
    String? url = '';

    await cloudinary
        .unsignedUpload(
      uploadPreset: uploadPreset,
      file: filePath,
      resourceType: CloudinaryResourceType.image,
      folder: "social_media_api/avatars",
      progressCallback: (count, total) {
        var progress = ((count / total) * 100).toStringAsFixed(2);
        AppUtils.printLog('Uploading : $progress %');
      },
    )
        .then((value) {
      publicId = value.publicId;
      url = value.secureUrl;
    }).catchError((err) {
      AppUtils.printLog(err);
      AppUtils.showSnackBar('image upload failed.', StringValues.error);
    });

    final body = {
      "public_id": publicId,
      "url": url,
    };

    try {
      final response = await _apiProvider.uploadProfilePicture(
        _auth.token,
        body,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.closeDialog();
        AppUtils.printLog("Update Profile Picture Success");
        await _profile.fetchProfileDetails(fetchPost: false);
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        AppUtils.printLog("Update Profile Picture Error");
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      AppUtils.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      AppUtils.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      AppUtils.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      AppUtils.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _removeProfilePicture() async {
    AppUtils.printLog("Remove Profile Picture Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.deleteProfilePicture(_auth.token);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.closeDialog();
        AppUtils.printLog("Remove Profile Picture Success");
        await _profile.fetchProfileDetails();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        AppUtils.printLog("Remove Profile Picture Error");
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      AppUtils.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      AppUtils.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      AppUtils.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      AppUtils.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> uploadProfilePicture() async {
    AppUtils.closeFocus();
    await _uploadProfilePicture();
  }

  Future<void> removeProfilePicture() async {
    AppUtils.closeFocus();
    await _removeProfilePicture();
  }
}
