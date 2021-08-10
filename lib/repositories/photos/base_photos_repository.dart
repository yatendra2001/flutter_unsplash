import 'package:flutter/foundation.dart';
import 'package:flutter_upsplash/models/photo_model.dart';
import 'package:flutter_upsplash/repositories/repositories.dart';
import 'package:flutter_upsplash/models/models.dart';

abstract class BasePhotosRepository extends BaseRepository {
  Future<List<Photo>> searchPhotos({@required String query, int page});
}
