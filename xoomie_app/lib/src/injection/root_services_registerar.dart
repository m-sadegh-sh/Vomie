import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xoomie/src/auth/bloc/auth_bloc.dart';
import 'package:xoomie/src/auth/bloc/auth_repository.dart';
import 'package:xoomie/src/configuration/app_settings.dart';
import 'package:xoomie/src/injection/container.dart';
import 'package:xoomie/src/photos/bloc/photos_bloc.dart';
import 'package:xoomie/src/photos/bloc/photos_repository.dart';
import 'package:xoomie/src/router/bloc/router_bloc.dart';
import 'package:xoomie/src/sign_in/bloc/sign_in_with_email_bloc.dart';
import 'package:xoomie/src/sign_in/bloc/sign_in_repository.dart';
import 'package:xoomie/src/sign_in/bloc/sign_in_with_google_bloc.dart';
import 'package:xoomie/src/sign_out/bloc/sign_out_bloc.dart';
import 'package:xoomie/src/sign_out/bloc/sign_out_repository.dart';
import 'package:xoomie/src/sign_up/bloc/sign_up_repository.dart';
import 'package:xoomie/src/sign_up/bloc/sign_up_with_email_bloc.dart';
import 'package:xoomie/src/splash/bloc/splash_bloc.dart';
import 'package:xoomie/src/theme/bloc/theme_bloc.dart';

void registerRootServices() {
  registerSingleton<AppSettingsBase>(
    (_) => EnvironmentBasedAppSettings(
      values: dotenv.env,
    ),
  );

  registerSingleton(
    (_) => ThemeBloc(),
  );

  registerSingleton(
    (_) => RouterBloc(),
  );

  registerFactory<AuthRepositoryBase>(
    (c) => FirebaseAuthRepository(),
  );

  registerFactory(
    (c) => AuthBloc(
      repository: c(),
    ),
  );

  registerFactory(
    (c) => SplashBloc(),
  );

  registerFactory<SignUpRepositoryBase>(
    (c) => FirebaseSignUpRepository(),
  );

  registerFactory(
    (c) => SignUpWithEmailBloc(
      repository: c(),
    ),
  );

  registerFactory<SignInRepositoryBase>(
    (c) => FirebaseSignInRepository(),
  );

  registerFactory(
    (c) => SignInWithEmailBloc(
      repository: c(),
    ),
  );

  registerFactory(
    (c) => SignInWithGoogleBloc(
      repository: c(),
    ),
  );

  registerFactory<SignOutRepositoryBase>(
    (c) => FirebaseSignOutRepository(),
  );

  registerFactory(
    (c) => SignOutBloc(
      repository: c(),
    ),
  );

  registerFactory<PhotosRepositoryBase>(
    (c) {
      final appSettings = c<AppSettingsBase>();

      return UnsplashPhotosRepository(
        baseUrl: appSettings.unsplashBaseUrl,
        accessKey: appSettings.unsplashAccessKey,
      );
    },
  );

  registerFactory(
    (c) => PhotosBloc(
      repository: c(),
    ),
  );
}
