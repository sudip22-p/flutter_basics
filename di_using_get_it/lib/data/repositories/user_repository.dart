import 'package:di_using_get_it/data/services/api/api_service.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class UserRepository {
  final ApiService _api;
  UserRepository(this._api);

  Future<bool> authenticate(String username, String password) {
    return _api.login(username, password);
  }
}
