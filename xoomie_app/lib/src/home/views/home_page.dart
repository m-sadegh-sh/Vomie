import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xoomie/src/home/views/home_screen.dart';
import 'package:xoomie/src/injection/container.dart';
import 'package:xoomie/src/photos/bloc/photos_bloc.dart';
import 'package:xoomie/src/sign_out/bloc/sign_out_bloc.dart';

class HomePage extends Page {
  const HomePage({
    super.key,
  });

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => resolve<SignOutBloc>(),
          ),
          BlocProvider(
            create: (_) => resolve<PhotosBloc>(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
