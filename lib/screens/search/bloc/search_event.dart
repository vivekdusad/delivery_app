part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SearchRequested extends SearchEvent {
  String query;
  SearchRequested({this.query});
}
