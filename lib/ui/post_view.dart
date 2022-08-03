import 'package:flutter/material.dart';
import 'package:flutter_base_bloc_list/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      ///gzn_dart_builder
      body: Builder(
          builder: (context) {
            ///gzn_dart_blocread
            context.read<PostBloc>().add(PostInitEvent());

            ///gzn_dart_blocbuilder
            return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostOnLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostOnSuccessState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return BlocProvider.of<PostBloc>(context).add(PostRefreshEvent());
                  },
                  child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.list[index].title.toString()),
                          ),
                        );
                      }),
                );
              } else if (state is PostOnFailedState) {
                return Center(
                  child: Text('Error occured: ${state.exception.toString()}'),
                );
              } else {
                return Container();
              }
            });
          },
      ),
    );
  }
}
