import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/app_router.dart';
import 'package:test_test/data/repos/rest_repo.dart';

import 'consts/view_consts.dart';

class App extends StatelessWidget {
  final RestRepos restRepos;

  const App({required this.restRepos, super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter _appRouter = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestRepos>(
          create: (context) => restRepos,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: "Montserrat",
            errorColor: Colours.DANGER_6,
            textTheme: new TextTheme(
              labelMedium: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colours.NEUTRAL_9,
                fontSize: 14,
              ),
              button: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colours.NEUTRAL_1,
                fontSize: 16,
              ),
              caption: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colours.DANGER_6,
                fontSize: 12,
              ),
            )),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
