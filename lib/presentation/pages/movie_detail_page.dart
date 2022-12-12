import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recomendation/movie_recomendation_bloc.dart';
import 'package:ditonton/presentation/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailBloc>(context, listen: false)
          .add(OnMovieDetail(widget.id));
      // Provider.of<MovieDetailBloc>(context, listen: false)
      //     .add(OnMovieRecomendation(widget.id));
      // Provider.of<MovieDetailBloc>(context, listen: false)
      //     .add(OnMovieWatchlistStatus(widget.id));
          // context.read<MovieDetailBloc>().add(OnMovieDetail(widget.id)),
          // context.read<MovieRecomendationBloc>().add(OnMovieRecomendation(widget.id)),
          // context.read<MovieWatchlistBloc>().add(OnMovieWatchlistStatus(widget.id)),
        });
  }

  @override
  Widget build(BuildContext context) {
    // final _isAddedToWatchlist =
    // context.select<MovieDetailBloc, bool>((bloc) {
    //   if (bloc.state is MovieWatchlistStatus) {
    //     return (bloc.state as MovieWatchlistStatus).result;
    //   } else {
    //     return false;
    //   }
    // });
   
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        //listener: (context, state) async {
          // if (state.OnMovieWatchlistStatus ==
          //         MovieDetailBloc.watchlistAddSuccessMessage ||
          //     state.watchlistMessage ==
          //         MovieDetailBloc.watchlistRemoveSuccessMessage) {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text(state.watchlistMessage),
          //   ),);
          // } else {
          //   await showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           content: Text(state.watchlistMessage),
          //         );
          //       },);
          // }
        //},
        // listenWhen: (previousState, currentState) =>
        //     previousState.movieMessageWatchlist != currentState.movieMessageWatchlist &&
        //     currentState.movieMessageWatchlist != '',
        builder: (context, state) {
          if (state.movieDetailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.movieDetailState == RequestState.Loaded) {
            //  final movie = state.movieDetail!;
            return SafeArea(
              child: DetailContent(state.movieDetail!, state.movieIsAdded, state.movieRecomendation),
            );
          } else if (state.movieDetailState == RequestState.Error) {
            return Text(state.movieMessage);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedToWatchlist;
  final List<Movie> recomendations;
  DetailContent(this.movie, this.isAddedToWatchlist, this.recomendations);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ImageCard(pathImage: movie.posterPath, width: screenWidth),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedToWatchlist) {
                                  Future.microtask(() => {
                                        context
                                            .read<MovieDetailBloc>()
                                            .add(OnMovieWatchlistSave(movie)),
                                        context.read<MovieDetailBloc>().add(
                                            OnMovieWatchlistStatus(movie.id))
                                      });
                                } else {
                                  Future.microtask(() => {
                                        context
                                            .read<MovieDetailBloc>()
                                            .add(OnMovieWatchlistRemove(movie)),
                                        context.read<MovieDetailBloc>().add(
                                            OnMovieWatchlistStatus(movie.id))
                                      });
                                }

                                String message = !isAddedToWatchlist
                                    ? watchlistAddSuccessMessage
                                    : watchlistRemoveSuccessMessage;

                                if (message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedToWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            // BlocBuilder<MovieRecomendationBloc, MovieRecomendationState>(
                            //   builder: (context, state) {
                            //     if (state is MovieRecomendationLoading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (state is MovieRecomendationError) {
                            //       return Text(state.message);
                            //     } else if (state is MovieRecomendationHasData) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final movie = state.result[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     MovieDetailPage.ROUTE_NAME,
                            //                     arguments: movie.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: ImageCard(
                            //                       pathImage:
                            //                           movie.posterPath ?? ""),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount: state.result.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),
                            Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recomendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: ImageCard(
                                                  pathImage:
                                                      movie.posterPath ?? ""),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recomendations.length,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
