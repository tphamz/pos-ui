import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  // Base URL for the POS backend API
  // Loaded from .env file or defaults to localhost
  // Set API_BASE_URL in .env file (e.g., API_BASE_URL=http://127.0.0.1:8080)
  // For physical iOS devices: use your Mac's IP (e.g., http://192.168.1.104:8080)
  // Find your Mac's IP: ipconfig getifaddr en0
  static String get baseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:8080';
  }
  
  // API version prefix (if your API uses versioning)
  static const String apiPrefix = '/api/v1';
  
  // Full API base URL
  static String get apiBaseUrl => '$baseUrl$apiPrefix';
  
  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
