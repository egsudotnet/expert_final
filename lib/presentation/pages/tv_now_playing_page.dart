import 'package:ditonton/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvNowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _TvNowPlayingPageState createState() => _TvNowPlayingPageState();
}

class _TvNowPlayingPageState extends State<TvNowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvNowPlayingBloc>().add(OnTvNowPlaying()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Today TVs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
          builder: (context, state) {
            if (state is TvNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvNowPlayingHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvNowPlayingError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }
}
