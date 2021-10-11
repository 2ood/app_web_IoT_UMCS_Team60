
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/data/dto/server_resp_dto.dart';
import 'package:ucms/utils/user_util/user_provider.dart';
import 'package:ucms/utils/convert_utf8.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> login(Map<String, dynamic> json) async {
    Response resp = await _userProvider.login(json);
    dynamic headers = resp.headers;
    dynamic body = resp.body;
    final prefs = GetStorage();
    
    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      User newUser = User.fromJson(serverRespDto.data);

      newUser.token=headers["authorization"];
      
      
      return newUser;
    } else {
      prefs.write("loginFailureMsg",serverRespDto.msg);
      return User();
    }
  }

  Future<String> register(Map<String,dynamic> json) async {
    Response resp = await _userProvider.register(json);
    dynamic body = resp.body;
    final prefs = GetStorage();

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      Map<String, dynamic> data = serverRespDto.data;
      prefs.write("beacon_id", data["beacon_id"]);
    } else {}

    return serverRespDto.msg;
  }

  Future<Map<String,dynamic>> currentPosition(String tag) async {
    Response resp = await _userProvider.currentPosition(tag);
    dynamic body = resp.body;

    Map<String, dynamic> convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);

    Map<String, dynamic> data = serverRespDto.data;
      return data;
  }

  Future<List<Map<String, dynamic>>> currentPositionAll() async {
    Response resp = await _userProvider.currentPositionAll();
    dynamic body = resp.body;

    Map<String, dynamic> convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);

    List<Map<String, dynamic>> data = serverRespDto.data;
      return data;
  }

}
