import 'package:di_using_get_it/data/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginBloc {
  final UserRepository _userRepository;
  LoginBloc(this._userRepository);

  String? validateUsername(String username) {
    if (username.isEmpty) return 'Username is required';
    if (username.length < 3) return 'Too short';
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 4) return 'Too short';
    return null;
  }

  Future<String> attemptLogin(String username, String password) async {
    final userError = validateUsername(username);
    final passError = validatePassword(password);

    if (userError != null || passError != null) {
      return '${userError ?? ''} ${passError ?? ''}'.trim();
    }

    final success = await _userRepository.authenticate(username, password);
    return success ? 'Login successful ' : 'Invalid username or password ';
  }
}
