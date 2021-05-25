import 'package:dio/dio.dart';

import 'api_interface.dart';
import 'dio_service.dart';

class ApiService implements ApiInterface{
  late final DioService _dioService;

  ApiService() {
    final options = BaseOptions(
      baseUrl: "https://ez-tickets-backend.herokuapp.com/api/v1",
    );
    _dioService = DioService(
      baseOptions: options,
    );
  }

  @override
  Future<List<T>> getCollectionData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) converter,
  }) async {
    //Entire map of response
    final data = await _dioService.get(
      endpoint: endpoint,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      queryParams: queryParams,
      cancelToken: cancelToken,
    );

    //Items of table as json
    final List<dynamic> body = data['body'];

    //Returning the deserialized objects
    return body.map((dataMap) => converter(dataMap)).toList();
  }

  @override
  Future<T> getDocumentData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) converter,
  }) async {
    //Entire map of response
    final data = await _dioService.get(
      endpoint: endpoint,
      queryParams: queryParams,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    //Returning the deserialized object
    return converter(data['body']);
  }

  @override
  Future<T> setData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) converter,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.post(
      endpoint: endpoint,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return converter(dataMap);
  }

  @override
  Future<T> updateData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) converter,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.patch(
      endpoint: endpoint,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return converter(dataMap);
  }

  @override
  Future<T> deleteData<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) converter,
  }) async {
    //Entire map of response
    final dataMap = await _dioService.delete(
      endpoint: endpoint,
      data: data,
      options: Options(headers: {"requiresAuthToken": requiresAuthToken}),
      cancelToken: cancelToken,
    );

    return converter(dataMap);
  }

  @override
  void cancelRequests({CancelToken? cancelToken}){
    _dioService.cancelRequests(cancelToken: cancelToken);
  }
}
