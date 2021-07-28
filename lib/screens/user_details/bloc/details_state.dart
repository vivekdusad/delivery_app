part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}
class DetailsSaving extends DetailsState {}

class DetailsSaved extends DetailsState {}

class DetailsErrorOccured extends DetailsState {
  final FirebaseException e;
  DetailsErrorOccured(this.e);
}

class DetailsOpened extends DetailsState {
  final User user;
  DetailsOpened(this.user);
}
