import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/list_item_model.dart';
import '../network_service.dart';

class ListRepository {
  final NetworkService _networkService;
  final Logger _logger = Logger();

  ListRepository(this._networkService);

  Future<List<ListItemModel>> getList() async {
    try {
      final response = await _networkService.get('/list');
      _logger.d('Get List Response JSON: ${response.data}');
      final listResponse = ListResponseModel.fromJson(response.data);
      return listResponse.list;
    } catch (error) {
      _logger.e('Failed to fetch list: $error');
      rethrow;
    }
  }

  Future<ListItemModel> getElement(String id) async {
    try {
      final response = await _networkService.get('/list/$id');
      _logger.d('Get Element Response JSON: ${response.data}');
      final elementResponse = ElementResponseModel.fromJson(response.data);
      return elementResponse.element;
    } catch (error) {
      _logger.e('Failed to fetch element: $error');
      rethrow;
    }
  }

  Future<ListItemModel> addElement(ListItemModel element, int revision) async {
    try {
      final jsonPayload = element.toJson();
      _logger.d('Add Element Request JSON: $jsonPayload');

      final response = await _networkService.post(
        '/list/${element.id}',
        data: jsonPayload,
        options: Options(headers: {
          'X-Last-Known-Revision': revision.toString(),
        }),
      );

      _logger.d('Add Element Response JSON: ${response.data}');
      final elementResponse = ElementResponseModel.fromJson(response.data);
      return elementResponse.element;
    } catch (error) {
      _logger.e('Failed to add element: $error');
      rethrow;
    }
  }

  Future<ListItemModel> updateElement(
      ListItemModel element, int revision) async {
    try {
      final response = await _networkService.put(
        '/list/${element.id}',
        data: element.toJson(),
        options:
            Options(headers: {'X-Last-Known-Revision': revision.toString()}),
      );
      _logger.d('Update Element Response JSON: ${response.data}');
      final elementResponse = ElementResponseModel.fromJson(response.data);
      return elementResponse.element;
    } catch (error) {
      _logger.e('Failed to update element: $error');
      rethrow;
    }
  }

  Future<ListItemModel> deleteElement(String id, int revision) async {
    try {
      final response = await _networkService.delete(
        '/list/$id',
        options:
            Options(headers: {'X-Last-Known-Revision': revision.toString()}),
      );
      _logger.d('Delete Element Response JSON: ${response.data}');
      final elementResponse = ElementResponseModel.fromJson(response.data);
      return elementResponse.element;
    } catch (error) {
      _logger.e('Failed to delete element: $error');
      rethrow;
    }
  }

  Future<void> updateList(List<ListItemModel> list, int revision) async {
    try {
      final response = await _networkService.patch(
        '/list',
        data: ListResponseModel(list: list, revision: revision, status: '')
            .toJson(),
        options:
            Options(headers: {'X-Last-Known-Revision': revision.toString()}),
      );
      _logger.d('Update List Response JSON: ${response.data}');
      final listResponse = ListResponseModel.fromJson(response.data);
    } catch (error) {
      _logger.e('Failed to update list: $error');
      rethrow;
    }
  }
}
