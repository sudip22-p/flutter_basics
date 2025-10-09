import 'package:di_using_get_it/data/repositories/user_repository.dart';
import 'package:di_using_get_it/data/services/api/api_service.dart';
import 'package:di_using_get_it/presentation/blocs/login_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiService>()),
  );
  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<UserRepository>()));
}
