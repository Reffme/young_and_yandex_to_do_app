import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class NetworkService {
  static const String _baseUrl = 'https://beta.mrdekk.ru/todobackend';
  static const String _token = 'squiggle';

  final Dio _dio;
  final Logger _logger = Logger();

  NetworkService() : _dio = Dio();

  Future<Response> get(String endpoint) async {
    final options = _getOptions();
    _logger.d(
        'GET Request - URL: $_baseUrl$endpoint, Headers: ${options.headers}');
    try {
      final response = await _dio.get('$_baseUrl$endpoint', options: options);
      _logger.d(
          'GET Response - URL: $_baseUrl$endpoint, Headers: ${response.headers}, Body: ${response.data}');
      return response;
    } catch (error) {
      _logger.e('GET Request Error - URL: $_baseUrl$endpoint, Error: $error');
      rethrow;
    }
  }

  Future<Response> post(String endpoint,
      {dynamic data, Options? options}) async {
    final requestOptions = _getOptions(options);
    _logger.d(
        'POST Request - URL: $_baseUrl$endpoint, Headers: ${requestOptions.headers}, Body: $data');
    try {
      final response = await _dio.post('$_baseUrl$endpoint',
          data: data, options: requestOptions);
      _logger.d(
          'POST Response - URL: $_baseUrl$endpoint, Headers: ${response.headers}, Body: ${response.data}');
      return response;
    } catch (error) {
      _logger.e('POST Request Error - URL: $_baseUrl$endpoint, Error: $error');
      rethrow;
    }
  }

  Future<Response> put(String endpoint,
      {dynamic data, Options? options}) async {
    final requestOptions = _getOptions(options);
    _logger.d(
        'PUT Request - URL: $_baseUrl$endpoint, Headers: ${requestOptions.headers}, Body: $data');
    try {
      final response = await _dio.put('$_baseUrl$endpoint',
          data: data, options: requestOptions);
      _logger.d(
          'PUT Response - URL: $_baseUrl$endpoint, Headers: ${response.headers}, Body: ${response.data}');
      return response;
    } catch (error) {
      _logger.e('PUT Request Error - URL: $_baseUrl$endpoint, Error: $error');
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {Options? options}) async {
    final requestOptions = _getOptions(options);
    _logger.d(
        'DELETE Request - URL: $_baseUrl$endpoint, Headers: ${requestOptions.headers}');
    try {
      final response =
          await _dio.delete('$_baseUrl$endpoint', options: requestOptions);
      _logger.d(
          'DELETE Response - URL: $_baseUrl$endpoint, Headers: ${response.headers}, Body: ${response.data}');
      return response;
    } catch (error) {
      _logger
          .e('DELETE Request Error - URL: $_baseUrl$endpoint, Error: $error');
      rethrow;
    }
  }

  Future<int> getRevision() async {
    final response = await _dio.get('$_baseUrl/revision');
    final revision = response.data['revision'];
    return revision;
  }

  Future<Response> patch(String endpoint,
      {dynamic data, Options? options}) async {
    final requestOptions = _getOptions(options);
    _logger.d(
        'PATCH Request - URL: $_baseUrl$endpoint, Headers: ${requestOptions.headers}, Body: $data');
    try {
      final response = await _dio.patch('$_baseUrl$endpoint',
          data: data, options: requestOptions);
      _logger.d(
          'PATCH Response - URL: $_baseUrl$endpoint, Headers: ${response.headers}, Body: ${response.data}');
      return response;
    } catch (error) {
      _logger.e('PATCH Request Error - URL: $_baseUrl$endpoint, Error: $error');
      rethrow;
    }
  }

  Options _getOptions([Options? options]) {
    final defaultOptions = Options(
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (options != null) {
      final mergedHeaders = {
        ...defaultOptions.headers ?? {},
        ...options.headers ?? {},
      };
      return defaultOptions.copyWith(headers: mergedHeaders);
    }

    return defaultOptions;
  }
}
