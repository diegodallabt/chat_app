import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/firebase_auth_datasource.dart';
import 'data/repositories/firebase_auth_repository_impl.dart';
import 'domain/repositories/firebase_auth_repository.dart';
import 'domain/usecases/firebase_auth_usecase.dart';
import 'domain/usecases/firebase_auth_usecase_impl.dart';
import 'external/datasources/firebase_auth_datasource_impl.dart';
import 'presentation/bloc/login_bloc.dart';
import 'presentation/login_page.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    // FirebaseAuth instance
    i.addSingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    // DataSource
    i.addSingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(i.get<FirebaseAuth>()),
    );

    // Repository
    i.addSingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(i.get<FirebaseAuthDataSource>()),
    );

    // Use Case
    i.addSingleton<FirebaseAuthUseCase>(
      () => FirebaseAuthUseCaseImpl(i.get<FirebaseAuthRepository>()),
    );

    // Login BloC
    i.addSingleton<LoginBloc>(
      () => LoginBloc(loginUseCase: i.get<FirebaseAuthUseCase>()),
    );
  }

  @override
  void routes(RouteManager r) {
    final instantTransition = CustomTransition(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      transitionDuration: Duration.zero,
    );

    r.child(
      '/',
      child: (context) => LoginPage(
        loginBloc: context.read<LoginBloc>(),
      ),
      customTransition: instantTransition,
    );
  }
}
