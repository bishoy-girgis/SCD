import '../services/cache_helper.dart';

class EndPoints{
  static const String loginToken = "/token";
  static const String profileData = "/api/Empdata";
  static const String baseUrl = "https://scd.skin/mobile_api";
  static String token = SharedPref.get(key: "accessToken") ?? "";


}