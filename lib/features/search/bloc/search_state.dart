part of 'search_bloc.dart';

@immutable
class SearchState {
  RequestState uploadState;
  String imageString;
  List<Result> searchImageData;
  SearchState({
    this.uploadState = RequestState.defaults,
    this.searchImageData = const [],
    this.imageString = '',
  });
  SearchState copyWith({
    RequestState? uploadState,
    String? imageString,
    List<Result>? searchImageData,
  }) {
    return SearchState(
      uploadState: uploadState ?? this.uploadState,
      imageString: imageString ?? this.imageString,
      searchImageData: searchImageData ?? this.searchImageData,
    );
  }
}
