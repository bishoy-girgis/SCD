import '../services/cache_helper.dart';

class EndPoints {
  static const String baseUrl = "https://scd.skin/mobile_api";

  static String token = SharedPref.get(key: "accessToken") ?? "";

  static const String baseImage= "https://scd.skin";

  static const String loginToken = "/login/";

  static const String signUpToken = "/registration/";

  static const String resetPassword = "/reset_password/";

  static const String profileData = "/profile/";

  static const String scan = "/scd_history/";

}
