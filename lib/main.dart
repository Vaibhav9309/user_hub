import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/di/locator.dart';
import 'presentation/screens/user_list_screen.dart';
import 'presentation/bloc/user_bloc.dart';
import 'domain/usecases/get_users_usecase.dart';
import 'data/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _mode = ThemeMode.light;
  void changeTheme(ThemeMode mode) => setState(() => _mode = mode);

  @override
  Widget build(BuildContext context) {
    final repo = sl<UserRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserBloc(GetUsersUseCase(repo)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _mode,
        home: const UserListScreen(),
      ),
    );
  }
}
