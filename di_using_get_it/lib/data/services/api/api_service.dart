class ApiService {
  final Map<String, String> _userDB = {'sudip': '1234', 'admin': 'admin'};

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _userDB[username] == password;
  }
}
