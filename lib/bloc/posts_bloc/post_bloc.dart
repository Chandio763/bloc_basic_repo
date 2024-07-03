import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Cubit<PostState> {
  final ApiService apiService;

  PostBloc({required this.apiService}) : super(PostInitial());

  void fetchPosts(PostEvent event) async {
    if (event is FetchPosts || event is RefreshPosts) {
      emit(PostLoading());
      try {
        final posts = await apiService.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError('Failed to fetch posts'));
      }
    }
  }
}