import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isLoading = false.obs;
  final RxString _userEmail = ''.obs;
  final RxString _userName = ''.obs;

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoading => _isLoading.value;
  String get userEmail => _userEmail.value;
  String get userName => _userName.value;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final token = _storage.read('auth_token');
    if (token != null) {
      _isLoggedIn.value = true;
      _userEmail.value = _storage.read('user_email') ?? '';
      _userName.value = _storage.read('user_name') ?? '';
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful login
      _storage.write('auth_token', 'mock_token_${DateTime.now().millisecondsSinceEpoch}');
      _storage.write('user_email', email);
      _storage.write('user_name', email.split('@')[0]);
      
      _isLoggedIn.value = true;
      _userEmail.value = email;
      _userName.value = email.split('@')[0];
      
      Get.offAllNamed(AppRoutes.home);
      Get.snackbar('Success', 'Login successful!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Please try again.', snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      _isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful registration
      _storage.write('auth_token', 'mock_token_${DateTime.now().millisecondsSinceEpoch}');
      _storage.write('user_email', email);
      _storage.write('user_name', name);
      
      _isLoggedIn.value = true;
      _userEmail.value = email;
      _userName.value = name;
      
      Get.offAllNamed(AppRoutes.home);
      Get.snackbar('Success', 'Registration successful!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Registration failed. Please try again.', snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
    }
  }

  void logout() {
    _storage.remove('auth_token');
    _storage.remove('user_email');
    _storage.remove('user_name');
    
    _isLoggedIn.value = false;
    _userEmail.value = '';
    _userName.value = '';
    
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar('Success', 'Logged out successfully!', snackPosition: SnackPosition.BOTTOM);
  }
}
