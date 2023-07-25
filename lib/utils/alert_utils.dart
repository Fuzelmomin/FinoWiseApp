import 'package:fluttertoast/fluttertoast.dart';


class AlertUtils {
  static String checkdatanull(String data) {
    if (data == null || data == "null") {
      data = "";
    }
    return data;
  }

  static void showToast(String msg) {
    if (msg == null) {
      return;
    }
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1);
  }

}
