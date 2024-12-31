import 'package:get_it/get_it.dart';
import 'package:tdd_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_app/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_app/src/products/data/datasources/products_remote_data_source.dart';
import 'package:tdd_app/src/products/data/repositories/products_repo_impl.dart';
import 'package:tdd_app/src/products/domain/repositories/products_repo.dart';
import 'package:tdd_app/src/products/domain/usecases/get_product_by_id.dart';
import 'package:tdd_app/src/products/domain/usecases/get_products.dart';
import 'package:tdd_app/src/products/presentation/cubit/products_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()))
    ..registerLazySingleton(
        () => ProductsCubit(getProductById: sl(), getProducts: sl()))

    // Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => GetProductById(sl()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(sl()),
    )
    ..registerLazySingleton<ProductsRepo>(
        () => ProductsRepoImpl(ProductsRemoteDataSrcImpl(sl())))

    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSrcImpl(sl()),
    )

    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
