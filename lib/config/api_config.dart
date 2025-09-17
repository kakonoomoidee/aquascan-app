import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String baseUrl = dotenv.env['BASE_URL']!;

  // auth endpoints
  static final String login = "$baseUrl/login";
  static final String profile = "$baseUrl/profile";

  // data endpoints
  static final String upload = "$baseUrl/upload";
}
