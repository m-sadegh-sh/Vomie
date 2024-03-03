import 'dart:async';
import "package:collection/collection.dart";

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xoomie/src/http/client.dart';
import 'package:xoomie/src/photos/bloc/photos_event.dart';
import 'package:xoomie/src/photos/bloc/photos_repository.dart';
import 'package:xoomie/src/photos/bloc/photos_state.dart';
import 'package:xoomie/src/photos/models/photo_group_model.dart';

class PhotosBloc extends Bloc<PhotosEventBase, PhotosStateBase> {
  final PhotosRepositoryBase repository;

  PhotosBloc({
    required this.repository,
  }) : super(const PhotosInitialState()) {
    on<PhotosLoadEvent>(_onLoad);

    add(const PhotosLoadEvent());
  }

  Future<void> _onLoad(
    PhotosLoadEvent event,
    Emitter<PhotosStateBase> emit,
  ) async {
    try {
      emit(const PhotosLoadingState());

      final photos = await repository.load(
        page: event.page,
        perPage: event.perPage,
        orderBy: event.orderBy,
      );

      final format = DateFormat.yMd();
      final groups = photos
          .groupListsBy(
            (photo) => format.format(photo.createdAt),
          )
          .entries
          .map((entry) => PhotoGroupModel(
                date: format.parse(entry.key),
                photos: entry.value,
              ));

      emit(PhotosLoadedState(groups));
    } catch (e) {
      emit(PhotosLoadFailedState(
        unwrapError(e) ?? (x) => x.photosBlocLoadFailed,
      ));
    }
  }
}
