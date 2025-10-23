import 'package:get/get.dart';
import 'package:sky_jewelry/app/Services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final AuthService _authService = Get.find<AuthService>();

  // Reactive variables
  var isLoading = false.obs;
  var email = ''.obs;
  var name = ''.obs;
  var isOTPVerified = false.obs;
  var isLoggedIn = false.obs;
  var userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFromStorage();
  }

  // Initialize controller state from storage
  void _initializeFromStorage() {
    isLoggedIn.value = _authService.isLoggedIn();
    isOTPVerified.value = _authService.isOTPVerified();
    email.value = _authService.getStoredEmail() ?? '';
    name.value = _authService.getStoredName() ?? '';

    if (_authService.getUserData() != null) {
      userData.value = Map<String, dynamic>.from(_authService.getUserData()!);
    }

    print(
      'AuthController initialized - LoggedIn: ${isLoggedIn.value}, Email: ${email.value}',
    );
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await _authService.login(email, password);

      if (response['success'] == true) {
        isLoggedIn.value = true;
        this.email.value = email;

        // Update name from stored data
        name.value = _authService.getStoredName() ?? 'User';

        Get.snackbar('Success', response['message'] ?? 'Login successful');

        // Navigate to home screen
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Send OTP
  Future<void> sendOTP(String email) async {
    try {
      isLoading.value = true;

      final response = await _authService.sendOTP(email);

      if (response['success'] == true) {
        this.email.value = email;
        Get.snackbar('Success', response['message'] ?? 'OTP sent successfully');
        // Navigate to OTP verification screen
        Get.toNamed('/otp-verification');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while sending OTP');
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOTP(String email, String otp) async {
    try {
      isLoading.value = true;

      final response = await _authService.verifyOTP(email, otp);

      if (response['success'] == true) {
        isOTPVerified.value = true;
        Get.snackbar(
          'Success',
          response['message'] ?? 'OTP verified successfully',
        );

        // After OTP verification, proceed with registration
        await _completeRegistration();
      } else {
        Get.snackbar('Error', response['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while verifying OTP');
    } finally {
      isLoading.value = false;
    }
  }

  // Start registration process (send OTP first)
  Future<void> register(String name, String email, String password) async {
    try {
      // Store the name temporarily
      this.name.value = name;

      // Store the registration data temporarily in GetStorage
      _authService.storeTempRegistrationData(name, email, password);

      // First send OTP
      await sendOTP(email);
    } catch (e) {
      Get.snackbar('Error', 'Failed to start registration process');
    }
  }

  // Complete registration after OTP verification
  Future<void> _completeRegistration() async {
    try {
      isLoading.value = true;

      // Get stored registration data
      final tempData = _authService.getTempRegistrationData();

      final response = await _authService.register(
        tempData['name']!,
        tempData['email']!,
        tempData['password']!,
      );

      if (response['success'] == true) {
        userData.value = response['data'] ?? {};
        isLoggedIn.value = true;

        // Update name from response data if available
        if (response['data'] != null) {
          name.value =
              response['data']['name'] ??
              response['data']['full_name'] ??
              response['data']['username'] ??
              tempData['name']!;
        }

        Get.snackbar(
          'Success',
          response['message'] ?? 'Registration successful',
        );

        // Clear temporary data
        _authService.clearTempRegistrationData();

        // Navigate to home or success screen
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Registration failed');
        // Optionally navigate back to registration or stay on OTP screen
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during registration');
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _authService.logout();
      isLoggedIn.value = false;
      userData.value = {};
      email.value = '';
      name.value = '';
      isOTPVerified.value = false;

      Get.snackbar('Success', 'Logged out successfully');
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed');
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (email.value.isNotEmpty) {
      await sendOTP(email.value);
    }
  }

  // Check if user is logged in on app start
  void checkAuthStatus() {
    isLoggedIn.value = _authService.isLoggedIn();
    if (isLoggedIn.value) {
      // User is logged in, navigate to home
      Get.offAllNamed('/home');
    } else {
      // User is not logged in, navigate to login
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    _authService.clearTempRegistrationData();
    super.onClose();
  }
}
