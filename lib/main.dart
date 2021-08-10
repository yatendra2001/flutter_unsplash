import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_upsplash/blocs/blocs.dart';
import 'package:flutter_upsplash/repositories/repositories.dart';
import 'package:flutter_upsplash/screens/screens.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PhotosRepository(),
      child: BlocProvider(
        create: (context) =>
            PhotosBloc(photosRepository: context.read<PhotosRepository>())
              ..add(PhotosSearchPhotos(query: 'Programming')),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: PhotosScreen(),
        ),
      ),
    );
  }
}
