import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/data/dto/login_request_dto.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/beacon/beacon_manager.dart';
import 'package:ucms/utils/user_util/user_repository.dart';

class UserController extends GetxController {
  final RxBool isLogin = false.obs;
  final appUser = User().obs;
  var prefs = GetStorage();
  UserSocketClient socket = Get.find<UserSocketClient>();
  BeaconManager beaconManager = Get.find<BeaconManager>();

  void logout() {
    isLogin.value=false;
    prefs.write("location","");
    prefs.write("state","");
    prefs.write("token", "");
  }

  Future<String> login(tag, password) async {
    final loginDto = LoginRequestDto(tag: tag, password: password);
    final repository = UserRepository();
    final newUser = await repository.login(loginDto.toJson());

    if (newUser.tag != "") {
      isLogin.value = true;
      appUser.value = newUser;
      //socket.locationReport(macAddress : beaconManager.beaconResult.macAddress!, scanTime: beaconManager.beaconResult.scanTime!);
      //TODO :  location 읽어온 것으로 User 다시 update 해줘야 함. 
      User.updatePrefs(newUser);
      return "success";
    } else {
      return prefs.read("loginFailureMsg")??"에러메시지in UserController";
    }
  }

   Future<String> register(Map<String, dynamic> json) async {
    //final registerDto = RegisterRequestDto.fromJson(json);
    final repository = UserRepository();
    final message = await repository.register(json);
    return message;
  }

  Future<Map<String,dynamic>> userInfo(String tag) async {
    //final registerDto = RegisterRequestDto.fromJson(json);
    final repository = UserRepository();
    final data = await repository.userInfo(tag);
    return data;
  }
}
