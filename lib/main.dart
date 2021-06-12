import 'package:awesome_app/presenter/blocs/photos/photos_bloc.dart';
import 'package:awesome_app/presenter/screens/main_screen.dart';
import 'package:awesome_app/router.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache_helper.dart';
import 'core/network/network_info..dart';
import 'data/datasource/photo_local_datasource.dart';
import 'data/datasource/photo_remote_datasource.dart';
import 'data/repositories/photo_repository_impl.dart';
import 'domain/usecase/get_photos.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp(this.prefs);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PhotosBloc(
          getPhotos: GetPhotos(repository: PhotoRepositoryImpl(
            remoteDatasource: PhotoRemoteDatasourceImpl(),
            localDatasource: PhotoLocalDatasourceImpl(
              CacheHelper(prefs)
            ),
            networkInfo: NetworkInfoImpl(Connectivity())
          )))
        )
      ], 
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Lato"
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterGenerator.generatedRoute,
      )
    );
  }
}
