import '../services/cache_helper.dart';

class EndPoints{
  static const String loginToken = "/login/";
  static const String profileData = "/profile/";

  static const String baseUrl = "https://scd.skin/mobile_api";
  static String token = SharedPref.get(key: "accessToken") ?? "";


}