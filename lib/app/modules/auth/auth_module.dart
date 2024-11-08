import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/firebase_auth_datasource.dart';
import 'data/repositories/firebase_auth_repository_impl.dart';
import 'domain/repositories/firebase_auth_repository.dart';
import 'domain/usecases/firebase_auth_usecase.dart';
import 'domain/usecases/firebase_auth_usecase_impl.dart';
import 'external/datasources/firebase_auth_datasource_impl.dart';
import 'presentation/bloc/auth_bloc.dart';
import 'presentation/auth_page.dart';

class AuthModule extends Module {
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
    i.addSingleton<AuthBloc>(
      () => AuthBloc(authUseCase: i.get<FirebaseAuthUseCase>()),
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
      child: (context) => AuthPage(
        loginBloc: context.read<AuthBloc>(),
      ),
      customTransition: instantTransition,
    );
  }
}
