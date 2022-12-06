part of 'popular_tvs_bloc.dart';
 
abstract class PopularTvsState extends Equatable {}
 
class PopularTvsEmpty extends PopularTvsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class PopularTvsLoading extends PopularTvsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class PopularTvsError extends PopularTvsState {
  final String message;
 
  PopularTvsError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class PopularTvsHasData extends PopularTvsState {
  final List<Tv> result;
 
  PopularTvsHasData(this.result);
 
  @override
  List<Object> get props => [result];
}