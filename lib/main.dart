import 'package:flutter/material.dart';
import 'package:flutter_base_bloc_list/ui/post_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///gzn_dart_blocmulti
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PostBloc>(create: (context) => PostBloc())
        ],
        child: const PostView(),
      ),
    );
  }
}
