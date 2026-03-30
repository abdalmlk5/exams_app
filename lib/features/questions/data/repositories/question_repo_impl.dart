import 'package:injectable/injectable.dart';

import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/questions/data/datasources/question_remote_data_source_contract.dart';
import 'package:exams_app/features/questions/data/models/check_questions_response_model.dart';
import 'package:exams_app/features/questions/data/models/question_model.dart';
import 'package:exams_app/features/questions/data/models/submit_answers_request_model.dart';
import 'package:exams_app/features/questions/domain/entities/check_questions_response_entity.dart';
import 'package:exams_app/features/questions/domain/entities/question_entity.dart';
import 'package:exams_app/features/questions/domain/entities/submit_answers_request_entity.dart';
import 'package:exams_app/features/questions/domain/repositories/question_repo.dart';

@LazySingleton(as: QuestionRepoContract)
class QuestionRepoImpl implements QuestionRepoContract {
  final QuestionRemoteDataSourceContract _questionRemoteDataSourceContract;

  QuestionRepoImpl({
    required QuestionRemoteDataSourceContract questionRemoteDataSourceContract,
  }) : _questionRemoteDataSourceContract = questionRemoteDataSourceContract;

  @override
  Future<BaseResponse<List<QuestionEntity>>> getQuestions({
    required String examId,
    int? page,
    int? limit,
  }) async {
    final response = await _questionRemoteDataSourceContract.getQuestions(
      examId: examId,
      page: page,
      limit: limit,
    );

    switch (response) {
      case SuccessBaseResponse<List<QuestionModel>>():
        return SuccessBaseResponse<List<QuestionEntity>>(
          response.data.map((e) => e.toEntity()).toList(),
        );
      case ErrorBaseResponse<List<QuestionModel>>():
        return ErrorBaseResponse<List<QuestionEntity>>(response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<CheckQuestionsResponseEntity>> checkQuestions({
    required SubmitAnswersRequestEntity body,
  }) async {
    final response = await _questionRemoteDataSourceContract.checkQuestions(
      body: SubmitAnswersRequestModel.fromEntity(body),
    );

    switch (response) {
      case SuccessBaseResponse<CheckQuestionsResponseModel>():
        return SuccessBaseResponse<CheckQuestionsResponseEntity>(
          response.data.toEntity(),
        );
      case ErrorBaseResponse<CheckQuestionsResponseModel>():
        return ErrorBaseResponse<CheckQuestionsResponseEntity>(response.errorMessage);
    }
  }
}
