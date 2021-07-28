import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final Database database;
  DetailsBloc({this.database}) : super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    final localStorage = await ProviderContainer().read(localStorageProvider);
    final user = await localStorage.getUserFromStorage();
    if (event is DetailsPageOpened) {
      yield DetailsLoading();
      yield DetailsOpened(user);
    } else if (event is UpdateDetails) {
      yield DetailsSaving();
      try {
        await database.updateUser(event.user);
        await localStorage.saveUserToStorage(event.user);
        yield DetailsSaved();
      } on FirebaseException catch (e) {
        yield DetailsErrorOccured(e);
      }
    }
  }
}
