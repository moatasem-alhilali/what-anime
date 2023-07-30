import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:anime_finder/core/failure/request_state.dart';
import 'package:anime_finder/core/helper/db/sqflite.dart';
import 'package:anime_finder/core/helper/dio_helper/dio_helper.dart';
import 'package:anime_finder/features/home/bloc/home_bloc.dart';
import 'package:anime_finder/features/home/model/anime_model.dart';
import 'package:anime_finder/features/search/model/search_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqlite_api.dart';

part 'search_event.dart';
part 'search_state.dart';

bool isNull = true;
XFile? fileImage;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<UploadImageEvent>(uploadImage);
  }

  FutureOr<void> uploadImage(event, emit) async {
    emit(
      state.copyWith(
        searchImageData: [],
        uploadState: RequestState.defaults,
      ),
    );
    Uint8List? bytes;
    try {
      final ImagePicker _picker = ImagePicker();
      fileImage = await _picker.pickImage(source: ImageSource.gallery);
      // defaults
      if (fileImage == null) {
        return;
      } else {
        //pickImage
        emit(
          state.copyWith(
            uploadState: RequestState.pickImage,
            imageString: fileImage!.path,
          ),
        );
      }

      (fileImage!.path);
      String fileName = fileImage!.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          "images":
              await MultipartFile.fromFile(fileImage!.path, filename: fileName),
        },
      );

      //Loading
      emit(
        state.copyWith(
          uploadState: RequestState.loading,
        ),
      );

      SearchImageData? searchImageData;
      final result = await DioHelper.post(
        url: "https://api.trace.moe/search",
        data: formData,
      );
      searchImageData = SearchImageData.fromJson(result.data);

      //success
      emit(
        state.copyWith(
          uploadState: RequestState.success,
          searchImageData: searchImageData.result!,
        ),
      );

      if (fileImage!.path.isEmpty == false) {
        fileImage = XFile(fileImage!.path);
        String? imageString;

        //!------------------------------------------------------------
        bytes = File(fileImage!.path).readAsBytesSync();
        imageString = base64Encode(bytes);
        parseAndSaveData(responseData: result.data, image: imageString);

        //!------------------------------------------------------------
      }
    } catch (e) {
      print(e);
      //error
      emit(state.copyWith(uploadState: RequestState.error));
    }
  }
}

void parseAndSaveData({
  required dynamic responseData,
  required String image,
}) async {
  try {
    var length = await DBHelper.getAll();
    var countId = length.length;

    print(length.length);
    final animeObject = AnimeModel(
      id: countId,
      frameCount: responseData['frameCount'],
      imageGallery: image,
      createdAt: DateTime.now().toString(),
    );

    await DBHelper.insertAnime(animeObject);

    for (var info in responseData['result']) {
      final episodeObject = InfoModel(
        animeId: countId,
        anilist: info['anilist'],
        episode: info['episode'],
        filename: info['filename'],
        from: info['from'],
        image: info['image'],
        video: info['video'],
        to: info['to'],
        similarity: info['similarity'],
      );
      await DBHelper.insertInfo(episodeObject);
    }
  } on DatabaseException catch (e) {
    if (e.isUniqueConstraintError()) {
      print('isUniqueConstraintError');
    } else {}
  }
}
