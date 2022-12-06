import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:flutter/foundation.dart';

class TvNowPlayingNotifier extends ChangeNotifier {
  final GetNowPlayingTvs getTvNowPlaying;

  TvNowPlayingNotifier(this.getTvNowPlaying);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvNowPlaying() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvNowPlaying.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
