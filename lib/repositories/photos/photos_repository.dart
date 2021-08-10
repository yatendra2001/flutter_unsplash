import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_upsplash/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_upsplash/models/photo_model.dart';
import '../repositories.dart';
import 'package:flutter_upsplash/.env.dart';

class PhotosRepository extends BasePhotosRepository {
  static const _upsplashUrl = 'https://api.unsplash.com/';
  static const int numPerPage = 10;

  final http.Client _httpClient;

  PhotosRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  void dispose() {
    _httpClient.close();
  }

  @override
  Future<List<Photo>> searchPhotos({
    @required String query,
    int page = 1,
  }) async {
    final url =
        '$_upsplashUrl/search/photos?client_id=$unsplashApiKey&page=$page&per_page=$numPerPage&query=$query';
    final response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List results = data['results'];
      final List<Photo> photos = results.map((e) => Photo.fromMap(e)).toList();
      return photos;
    }
    throw FailureModel();
  }
}
