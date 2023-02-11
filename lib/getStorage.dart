import 'package:get_storage/get_storage.dart';

class LoginGetStorage {
  static String getToken() {
    final box = GetStorage();
    return box.read("Token") ?? "";
  }
    static String getNumber() {
    final box = GetStorage();
    return box.read("Number") ?? "";
  }

  static setToken(String Token) {
    final box = GetStorage();
    box.write("Token", Token);
  }

    static setNumber(String Number) {
    final box = GetStorage();
    box.write("Number", Number);
  }
}