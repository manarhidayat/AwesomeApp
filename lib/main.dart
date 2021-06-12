import 'package:awesome_app/presenter/blocs/photos/photos_bloc.dart';
import 'package:awesome_app/presenter/screens/main_screen.dart';
import 'package:awesome_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/datasource/photo_remote_datasource.dart';
import 'data/repositories/photo_repository_impl.dart';
import 'domain/usecase/get_photos.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PhotosBloc(
          getPhotos: GetPhotos(repository: PhotoRepositoryImpl(
            remoteDatasource: PhotoRemoteDatasourceImpl()
          )))
        )
      ], 
      child: MaterialApp(
        theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterGenerator.generatedRoute,
      )
    );
  }
}
