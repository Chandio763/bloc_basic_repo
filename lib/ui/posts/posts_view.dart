
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarty_editor_with_block/bloc/posts_bloc/post_state.dart';
import 'package:smarty_editor_with_block/model/post_model.dart';

import '../../bloc/posts_bloc/post_bloc.dart';
import '../../bloc/posts_bloc/post_event.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  
  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().fetchPosts(FetchPosts());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PostBloc>().fetchPosts(RefreshPosts());
            },
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            return const Center(child: Text('Welcome!'));
          } else if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostModel post = state.posts[index];
                return ListTile(
                  title: Text(post.id??''),
                  subtitle: Text(post.name??''),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}