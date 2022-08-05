# flutter_base_bloc_list

- post.dart
```dart
class Post {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  Post({this.userId, this.id, this.title, this.body});

  ///gzn_dart_http_future
  factory Post.fromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);
}
```
- data_service.dart
```dart
import 'dart:convert';

import 'package:flutter_base_bloc_list/model/post.dart';
import 'package:http/http.dart' as http;

class DataService{
  final _baseUrl = 'jsonplaceholder.typicode.com';

  ///gzn_dart_http_future
  Future<List<Post>> getPost() async{
      try{
        final url = Uri.https(_baseUrl, '/posts');
        final response = await http.get(url);
        final json = jsonDecode(response.body) as List;
        final res = json.map((e) => Post.fromJson(e)).toList();
        return res;
      } on Error catch(e){
        throw e;
      }
  }
}
```
- post_bloc.dart
```dart
import 'package:flutter_base_bloc_list/data/data_service.dart';
import 'package:flutter_base_bloc_list/model/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///gzn_dart_blocinit
//event
abstract class PostEvent{}

class PostInitEvent extends PostEvent{}

class PostRefreshEvent extends PostEvent{}

//state
abstract class PostState{}

class PostOnLoadingState extends PostState{}

class PostOnSuccessState extends PostState{
  final List<Post> list;

  PostOnSuccessState(this.list);
}

class PostOnFailedState extends PostState{
  final Error exception;

  PostOnFailedState(this.exception);
}

//bloc
class PostBloc extends Bloc<PostEvent, PostState>{
  final _dataService = DataService();

  PostBloc() : super(PostOnLoadingState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if(event is PostInitEvent || event is PostRefreshEvent){
      yield PostOnLoadingState();
      try{
        final res = await _dataService.getPost();
        yield PostOnSuccessState(res);
      } on Error catch(e){
        yield PostOnFailedState(e);
      }
    }
  }
}
```
- main.dart
```dart
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
```

---

```
Copyright 2022 M. Fadli Zein
```