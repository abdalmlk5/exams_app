import 'package:exams_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handler/error_handler.dart';
import '../../data/datasources/exams_data_source_contract.dart';
import '../../data/models/exams_response.dart';
import '../api_client/exams_api_client.dart';

@Injectable(as: ExamsDataSourceContract)
class ExamsDataSourceImpl extends ExamsDataSourceContract {
  final ExamsApiClient apiClient;

  ExamsDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<ExamsResponse>> getExams({required String token}) async {
    try {
      final response = await apiClient.getExams({"token": token});

      return SuccessBaseResponse<ExamsResponse>(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
