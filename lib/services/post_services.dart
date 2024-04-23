import 'dart:io';

import 'package:api_uses/services/coment_model.dart';
import 'package:api_uses/services/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IPostService {
  Future<bool> addItemToServices(PostModel postModel);
  Future<List<PostModel>?> fetchPostItemsAdvance();
  Future<List<CommentModel>?> fetchRelatedCommentsWithPostId(int postId);
}

class PostService implements IPostService {
  late final Dio _dio;
  PostService() : _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  @override
  Future<bool> addItemToServices(PostModel postModel) async {
    try {
      final response = await _dio.post(_PostServicesPath.posts.name, data: postModel);

      return response.statusCode == HttpStatus.created;
    } on DioException catch (exeception) {
      _ShowDebug.showDioError(exeception, this);
    }
    return false;
  }

  @override
  Future<List<PostModel>?> fetchPostItemsAdvance() async {
    try {
      final response = await _dio.get(_PostServicesPath.posts.name);

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDebug.showDioError(exception, this);
    }
    return null;
  }

  @override
  Future<List<CommentModel>?> fetchRelatedCommentsWithPostId(int postId) async {
    try {
      final response =
          await _dio.get(_PostServicesPath.comments.name, queryParameters: {_PostIdQuery.postId.name: postId});
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => CommentModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exepcition) {
      _ShowDebug.showDioError(exepcition, this);
    }
    return null;
  }
}

enum _PostServicesPath { posts, comments }

enum _PostIdQuery { postId }

class _ShowDebug {
  static void showDioError<T>(DioException error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print('-------------------');
    }
  }
}
