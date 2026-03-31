import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/explore/data/models/explore_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handler/error_handler.dart';
import '../../data/datasources/explore_data_source_contract.dart';
import '../api_client/explore_api_client.dart';

@Injectable(as: ExploreDataSourceContract)
class ExploreDataSourceImpl extends ExploreDataSourceContract {
  final ExploreApiClient apiClient;

  ExploreDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<ExploreResponse>> getSubjects({
    required String token,
  }) async {
    try {
      final response = await apiClient.getSubjects({"token": token});

      return SuccessBaseResponse<ExploreResponse>(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
