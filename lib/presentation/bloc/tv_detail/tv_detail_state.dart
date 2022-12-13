part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  final TvDetail? tvDetail;
  final bool tvIsAdded;
  final List<Tv> tvRecomendation;
  final String tvMessage;
  final RequestState tvDetailState;
  final String tvMessageWatchlist;

  const TvDetailState(
      {
      required this.tvDetail,
      required this.tvIsAdded,
      required this.tvRecomendation,
      required this.tvMessage,
      required this.tvDetailState,
      required this.tvMessageWatchlist
      });

  factory TvDetailState.loadFirst() {
    return const TvDetailState(
      tvDetail: null,
      tvMessage: '',
      tvDetailState: RequestState.Empty,
      tvIsAdded: false,
      tvRecomendation: [],
      tvMessageWatchlist:""
    );
  }

  TvDetailState copyWith({
    TvDetail? tvDetail,
    bool? tvIsAdded,
    List<Tv>? tvRecomendation,
    String? tvMessage,
    RequestState? tvDetailState,
    String? tvMessageWatchlist  }) {
    return TvDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvIsAdded: tvIsAdded ?? this.tvIsAdded,
      tvRecomendation: tvRecomendation ?? this.tvRecomendation,
      tvMessage: tvMessage ?? this.tvMessage,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      tvMessageWatchlist: tvMessageWatchlist ?? this.tvMessageWatchlist,
    );
  }

  @override
  List<Object?> get props => [
      tvDetail,
      tvMessage,
      tvDetailState,
      tvIsAdded,
      tvRecomendation,
      tvMessageWatchlist
  ];
}