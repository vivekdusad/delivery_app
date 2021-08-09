part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}

// ignore: must_be_immutable
class SearchLoaded extends SearchState {
  Stream<List<Product>> products;
  SearchLoaded({
    this.products,
  });
}

class SearchFailed extends SearchState {
 final Exception exception;

  SearchFailed(this.exception);
  
}
