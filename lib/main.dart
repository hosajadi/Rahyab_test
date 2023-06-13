import 'package:flutter/material.dart';
import 'package:test_test/app.dart';
import 'package:test_test/consts/data_const.dart';

import 'data/repos/rest_repo.dart';
import 'data/services/rest_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final RestServices restServices = new RestService(url: DataConst.BASE_URL);
  final RestRepos restRepos = new RestRepo(restServices: restServices);
  runApp(App(
    restRepos: restRepos,
  ));
}
