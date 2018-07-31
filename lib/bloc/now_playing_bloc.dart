import 'dart:async';

import 'package:cine_reel/api/tmdb_api.dart';
import 'package:cine_reel/bloc/movie_bloc.dart';
import 'package:cine_reel/ui/list_screen/movie_state.dart';

class NowPlayingBloc extends MovieBloc {
  NowPlayingBloc(TMDBApi api) : super(api);

  //the instance of MoviesPopulated state object that will be used for this Bloc
  MoviesPopulated moviesPopulated = MoviesPopulated([]);

  @override
	Stream<MoviesState> fetchMoviesFromNetwork() async* {
  	if (moviesPopulated.movies.isEmpty) {
			yield MoviesLoading();
		}

  	page+=1;
		try {
			final result = await api.nowPlayingMovies(page: page);
			if (result.isEmpty) {
				yield MoviesEmpty();
			} else {
				yield moviesPopulated.update(newMovies: result.results);
			}
		} catch (e) {
			print('error $e');
			yield MoviesError(e);
		}
	}
}