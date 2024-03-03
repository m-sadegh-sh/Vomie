import 'dart:async';
import 'package:dio/dio.dart';
import 'package:xoomie/src/http/client.dart';
import 'package:xoomie/src/photos/models/order_by.dart';
import 'package:xoomie/src/photos/models/photo_model.dart';

abstract class PhotosRepositoryBase {
  Future<List<PhotoModel>> load({
    required int page,
    required int perPage,
    required OrderBy orderBy,
  });
}

class UnsplashPhotosRepository extends PhotosRepositoryBase {
  late final Dio _client;

  UnsplashPhotosRepository({
    required String baseUrl,
    required String accessKey,
  }) {
    _client = createClient(
      baseUrl,
      authorization: 'Client-ID $accessKey',
    );
  }

  @override
  Future<List<PhotoModel>> load({
    required int page,
    required int perPage,
    required OrderBy orderBy,
  }) async {
    final response = await _client.get<Iterable<dynamic>>(
      'photos?page=$page&per_page=$perPage&order_by=$orderBy',
    );

    return response.data!.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
