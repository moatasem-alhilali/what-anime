// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// class ApiServes {
//   static const String baseUrl = 'http://10.0.2.2:8000/api/';
//   //Auth
//   static const String signUp = 'auth/register';
//   static const String logIn = 'auth/login';

// }

// Future<Response> uploadMultiImage() async {
//   List<XFile> images = await ImagePicker().pickMultiImage();

//   if (images.isEmpty) {
//     return Future.error('No images selected');
//   }

//   List<MultipartFile> files = [];

//   for (XFile image in images) {
//     Uint8List byteData = await image.readAsBytes();
//     List<int> imageData = byteData.buffer.asUint8List();
//     MultipartFile file = MultipartFile.fromBytes(
//       imageData,
//       filename: image.name,
//     );
//     files.add(file);
//   }

//   FormData formData = FormData.fromMap({
//     'images[]': files,
//     "title": "hello",
//     "quantity": 1,
//     "price": 500,
//     "sold": 1,
//     "priceAfterDiscount": 400,
//     "description": "descriptiondescriptiondescription",
//     "imageCover": "imageCover",
//     "colors": "colors",
//     "ratingsAverage": 1,
//     "ratingsQuantity": 1,
//     "category_id": 1,
//     "subcategories_id": 1,
//     "brand_id": 1,
//   });

//   print('Request body: $formData');

//   try {
//     Response response = await Dio().post(
//       'http://10.0.2.2:8000/api/store/product/create',
//       data: formData,
//     );

//     // ShowToast.show(message: 'success: ${response.data}');

//     print('success: ${response.data}');
//     return response;
//   } catch (e) {
//     // ShowToast.show(message: 'Error: $e');
//     print('Error: $e');
//     return Future.error(e);
//   }
// }

import 'package:anime_finder/core/helper/db/sqflite.dart';
import 'package:anime_finder/features/search/model/search_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// Future<Response> uploadImage() async {
//   XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

//   if (image == null) {
//     return Future.error('No image selected');
//   }

//   Uint8List byteData = await image.readAsBytes();
//   List<int> imageData = byteData.buffer.asUint8List();
//   MultipartFile file = MultipartFile.fromBytes(
//     imageData,
//     filename: image.name,
//   );

//   FormData formData = FormData.fromMap({
//     'url': file,
//   });

//   try {
//     Response response = await Dio().post(
//       'imagehttps://api.trace.moe/search',
//       data: formData,
//     );
//     print('Response: $response');
//     return response;
//   } catch (e) {
//     print('Error: $e');
//     return Future.error(e);
//   }
// }

