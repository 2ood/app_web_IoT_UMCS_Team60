import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:ucms/data/dto/move_request_dto.dart';
import 'package:ucms/data/hostnames.dart';
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/utils/convert_utf8.dart';
import 'package:ucms/utils/snackbar.dart';

class UserSocketClient extends GetxService {
  var prefs = GetStorage();
  late socket_io.Socket socket;

  void startSocket() {
    socket = Get.put(socket_io.io(
        socketHost,
        socket_io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({
          'authorization': prefs.read("token") == null
              ? ""
              : ("Bearer " + prefs.read("token")!)
        }) // optional
            .build()));
    socket.connect();

    socket.onConnect((_) {});

    socket.on("permission", (_) {
    });

    socket.on("your_status", (_) {

    });
    socket.on("refresh_status", (_) {});
    socket.on("assemble", (data) {
      dynamic json = convertUtf8ToObject(data);

      prefs.write("assemble_location", json["beacon_id"]);
      prefs.write("assemble_visible",true);
      Get.to(UserAssemble(location: prefs.read("assemble_location")));
      Snack.warn("소집 지시", "소집 지시가 내려왔습니다.");
    });
    socket.on("cohort_start", (data) {
      dynamic json = convertUtf8ToObject(data);
      bool flag =false;
      String tag = prefs.read("tag");
      for(int i=0; i<json["tag"].length;i++) {
        if(json["tag"][i]==tag) {
          flag =true;
          break;
        }
      }
      if(flag) {
        //TODO:  Cohort 페이지로 Get.offAll()
      }
    });
    socket.on("cohort_stop", (_) {});
  }

  void moveRequest({required String destination}) {
    MoveRequestDto dto = MoveRequestDto(destination: destination);
    socket.emit("move_request", dto.toJson());
  }

  void locationReport({required String macAddress, required String scanTime}) {
    startSocket();
    Map<String, dynamic> json = {
      "tag": prefs.read("tag"),
      "beacon_id": macAddress,
      "time": scanTime,
    };

    socket.emit("location_report", json);
  }

  void cannotAssemble({required String description}) {
    startSocket();
    Map<String, dynamic> json = {
      "tag": prefs.read("tag"),
      "description" : description
    };

    socket.emit("cannot_assemble", json);
  }
}