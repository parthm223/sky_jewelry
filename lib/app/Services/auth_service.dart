import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  static const String baseUrl = 'https://purnajewels.com/api';
  late GetStorage _storage;

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _emailKey = 'user_email';
  static const String _nameKey = 'user_name';
  static const String _otpVerifiedKey = 'otp_verified';

  @override
  Future<void> onInit() async {
    super.onInit();
    _storage = GetStorage();
  }

  // Login API
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/login'));
      request.fields.addAll({'email': email, 'password': password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print('Login Response Status: ${response.statusCode}');
      print('Login Response Body: $responseBody');

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        // Store authentication data
        _storeAuthData(data, email);

        return {
          'success': true,
          'message': data['message'] ?? 'Login successful',
          'data': data,
        };
      } else {
        var errorData = json.decode(responseBody);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
          'error': response.reasonPhrase,
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('Login Error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // Send OTP API
  Future<Map<String, dynamic>> sendOTP(String email) async {
    try {
      var headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/send-otp'),
      );
      request.fields.addAll({'email': email});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print('Send OTP Response Status: ${response.statusCode}');
      print('Send OTP Response Body: $responseBody');

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        // Store email for OTP verification
        _storage.write(_emailKey, email);

        return {
          'success': true,
          'message': data['message'] ?? 'OTP sent successfully',
          'data': data,
        };
      } else {
        var errorData = json.decode(responseBody);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to send OTP',
          'error': response.reasonPhrase,
        };
      }
    } catch (e) {
      print('Send OTP Error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // Verify OTP API
  Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    try {
      var headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/verify-otp'),
      );
      request.fields.addAll({'email': email, 'otp': otp});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print('Verify OTP Response Status: ${response.statusCode}');
      print('Verify OTP Response Body: $responseBody');

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        // Mark OTP as verified in storage
        _storage.write(_otpVerifiedKey, true);
        _storage.write(_emailKey, email);

        return {
          'success': true,
          'message': data['message'] ?? 'OTP verified successfully',
          'data': data,
        };
      } else {
        var errorData = json.decode(responseBody);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Invalid OTP',
          'error': response.reasonPhrase,
        };
      }
    } catch (e) {
      print('Verify OTP Error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // Register API
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      var headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/register'),
      );
      request.fields.addAll({
        'name': name,
        'password': password,
        'email': email,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print('Register Response Status: ${response.statusCode}');
      print('Register Response Body: $responseBody');

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        // Store authentication data
        _storeAuthData(data, email);

        return {
          'success': true,
          'message': data['message'] ?? 'Registration successful',
          'data': data,
        };
      } else {
        var errorData = json.decode(responseBody);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Registration failed',
          'error': response.reasonPhrase,
        };
      }
    } catch (e) {
      print('Register Error: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // Store authentication data
  void _storeAuthData(Map<String, dynamic> data, String email) {
    try {
      // Extract token and user data from response (adjust based on your API response)
      String? token =
          data['token'] ?? data['access_token'] ?? data['data']['token'];
      Map<String, dynamic>? userData = data['user'] ?? data['data'];

      if (token != null) {
        _storage.write(_tokenKey, token);
        print('Token stored: $token');
      }

      if (userData != null) {
        _storage.write(_userDataKey, userData);

        // Extract and store name
        String? userName =
            userData['name'] ?? userData['full_name'] ?? userData['username'];
        if (userName != null) {
          _storage.write(_nameKey, userName);
          print('Name stored: $userName');
        }

        print('User data stored: $userData');
      }

      _storage.write(_isLoggedInKey, true);
      _storage.write(_emailKey, email);
      _storage.write(
        _otpVerifiedKey,
        false,
      ); // Reset OTP verification after registration/login

      print('Authentication data stored successfully');
    } catch (e) {
      print('Error storing auth data: $e');
    }
  }

  // Get stored data methods
  String? getToken() => _storage.read(_tokenKey);
  Map<String, dynamic>? getUserData() => _storage.read(_userDataKey);
  bool isLoggedIn() => _storage.read(_isLoggedInKey) ?? false;
  String? getStoredEmail() => _storage.read(_emailKey);
  String? getStoredName() => _storage.read(_nameKey);
  bool isOTPVerified() => _storage.read(_otpVerifiedKey) ?? false;

  // Clear storage (logout)
  Future<void> logout() async {
    await _storage.erase();
    print('User logged out, storage cleared');
  }

  // Store temporary registration data
  void storeTempRegistrationData(String name, String email, String password) {
    _storage.write('temp_name', name);
    _storage.write('temp_email', email);
    _storage.write('temp_password', password);
  }

  // Get temporary registration data
  Map<String, String> getTempRegistrationData() {
    return {
      'name': _storage.read('temp_name') ?? '',
      'email': _storage.read('temp_email') ?? '',
      'password': _storage.read('temp_password') ?? '',
    };
  }

  // Clear temporary data
  void clearTempRegistrationData() {
    _storage.remove('temp_name');
    _storage.remove('temp_email');
    _storage.remove('temp_password');
    _storage.remove(_otpVerifiedKey);
  }
}
