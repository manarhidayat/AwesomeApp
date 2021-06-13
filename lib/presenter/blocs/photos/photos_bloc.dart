import 'package:awesome_app/domain/usecase/get_photos.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_event.dart';
import 'package:awesome_app/presenter/blocs/photos/photos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  var page = 1;
  final GetPhotos _getPhotos;

  PhotosBloc({
    required GetPhotos getPhotos
  }): _getPhotos = getPhotos, super(PhotosState());

  initial() {}

  @override
  Stream<PhotosState> mapEventToState(PhotosEvent event) async* {
    if (event is PhotosFetched) {
      yield* _mapPostFetchedToState(state);
    } else if (event is PhotosInitial) {
      page = 1;
      PhotosState newState = state.copyWith(
        status: PhotosStatus.initial,
        list: List.of(state.list)..clear(),
        hasReachedMax: false,
      );
      yield newState;
      yield* _mapPostFetchedToState(state);
    }
  }

  Stream<PhotosState> _mapPostFetchedToState(PhotosState state) async* {
    if (state.hasReachedMax) yield state;

    if (state.status == PhotosStatus.initial) {
      page = 1;
      final res = await _getPhotos(ParamsGetPhotos(page));

      yield res.fold(
        (failure){
          return state.copyWith(
            status: PhotosStatus.failure,
            list: state.list,
            hasReachedMax: false,
          );
        },
        (response){
          return state.copyWith(
            status: PhotosStatus.success,
            list: response.photos,
            hasReachedMax: _hasReachedMax(response),
          );
        }
      );
    }
    page = page + 1;
    final res = await _getPhotos(ParamsGetPhotos(page));

    yield res.fold(
      (failure){
        return state.copyWith(
          status: PhotosStatus.failure,
          list: state.list,
          hasReachedMax: false,
        );
      },
      (response){
        return state.copyWith(
          status: PhotosStatus.success,
          list: List.of(state.list)..addAll(response.photos),
          hasReachedMax: _hasReachedMax(response),
        );
      }
    );
  }

  bool _hasReachedMax(response) => response.totalResults > page ? false : true;
}
