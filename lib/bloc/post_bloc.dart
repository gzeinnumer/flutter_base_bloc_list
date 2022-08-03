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


