import 'package:clean_arcticture/data/repositories/task_repository_impl.dart';
import 'package:clean_arcticture/data/sources/task_remote_data_source.dart';
import 'package:clean_arcticture/domain/repositories/task_repository.dart';
import 'package:clean_arcticture/domain/usecases/get_tasks.dart';
import 'package:clean_arcticture/presentation/state_management/task_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton(() => GetTasks(repository: sl()));

  sl.registerFactory(() => TaskProvider(getTasks: sl()));

  sl.registerLazySingleton(() => http.Client());
}
