import 'package:demo/services/firebase_auth.dart';
import 'package:demo/pages/authentication/model/user_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isAuthenticated = false.obs;

  UserModel? get user => _user.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isAuthenticated => _isAuthenticated.value;

  @override
  void onInit() {
    super.onInit();
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        _user.value = UserModel.fromFirebaseUser(user);
        _isAuthenticated.value = true;
      } else {
        _user.value = null;
        _isAuthenticated.value = false;
      }
      _isLoading.value = false;
    });
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      await _authService.signInWithEmail(email, password);
      return true;
    } catch (e) {
      _errorMessage.value = e.toString();
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      await _authService.signUpWithEmail(email, password);
      return true;
    } catch (e) {
      _errorMessage.value = e.toString();
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      final result = await _authService.signInWithGoogle();
      return result != null;
    } catch (e) {
      _errorMessage.value = e.toString();
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      await _authService.signOut();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      await _authService.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      _errorMessage.value = e.toString();
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
