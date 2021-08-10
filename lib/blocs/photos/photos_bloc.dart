import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upsplash/models/models.dart';
import 'package:flutter_upsplash/repositories/repositories.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosRepository _photosRepository;

  PhotosBloc({@required PhotosRepository photosRepository})
      : _photosRepository = photosRepository,
        super(PhotosState.initial());

  @override
  Stream<PhotosState> mapEventToState(
    PhotosEvent event,
  ) async* {
    if (event is PhotosSearchPhotos) {
      yield* _mapPhotosSearchPhotosToState(event);
    } else if (event is PhotoPaginate) {
      yield* _mapPhotosPaginateToState();
    }
  }

  Stream<PhotosState> _mapPhotosSearchPhotosToState(
    PhotosSearchPhotos event,
  ) async* {
    yield state.copyWith(query: event.query, status: PhotosStatus.loading);
    try {
      final photos = await _photosRepository.searchPhotos(query: event.query);
      yield state.copyWith(photos: photos, status: PhotosStatus.loaded);
    } catch (err) {
      print(err);
      yield state.copyWith(
          failure: FailureModel(
              message: 'Something went wrong! Please try a different search'),
          status: PhotosStatus.error);
    }
  }

  Stream<PhotosState> _mapPhotosPaginateToState() async* {
    yield state.copyWith(status: PhotosStatus.paginating);
    final photos = List<Photo>.from(state.photos);
    List<Photo> nextPhotos = [];
    if (photos.length >= PhotosRepository.numPerPage) {
      nextPhotos = await _photosRepository.searchPhotos(
          query: state.query,
          page: state.photos.length ~/ PhotosRepository.numPerPage + 1);
    }
    yield state.copyWith(
      photos: photos..addAll(nextPhotos),
      status: nextPhotos.isNotEmpty
          ? PhotosStatus.loaded
          : PhotosStatus.noMorePhotos,
    );
  }
}
