part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class UpdateDetails extends DetailsEvent {
  final Users user;
  UpdateDetails(this.user);
}
class DetailsPageOpened extends DetailsEvent{}
