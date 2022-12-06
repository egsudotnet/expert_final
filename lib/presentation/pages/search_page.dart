import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.tv)), 
              ],
            ),
            title: TextField(
                  onChanged: (query) {
                    context.read<MovieSearchBloc>().add(MovieOnQueryChanged(query));
                    context.read<TvSearchBloc>().add(TvOnQueryChanged(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search title',
                  ),
                  textInputAction: TextInputAction.search,
                ),
          ),
          body: TabBarView(
            children: [
              ResultMovie(),
              ResultTv(), 
            ],
          ),
        ), 
    );
  }
}

class ResultMovie extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                if (state is MovieSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieSearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 8,bottom: 5, left: 8),
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            )
          ]
    );
  
  }
}

class ResultTv extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              BlocBuilder<TvSearchBloc, TvSearchState>(
                builder: (context, state) {
                if (state is TvSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(right: 8,bottom: 5, left: 8),
                      itemBuilder: (context, index) {
                        final tv = state.result[index];
                        return TvCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            )
          ]
    );
  
  }
}