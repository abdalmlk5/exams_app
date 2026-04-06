import 'package:exams_app/features/authentication/data/models/user_model.dart';
import 'package:exams_app/features/exams/data/models/exam_model.dart' as exams_exam;
import 'package:exams_app/features/exams/data/models/exams_response.dart';
import 'package:exams_app/features/explore/data/models/subject_model.dart';
import 'package:exams_app/features/explore/data/models/explore_response.dart';
import 'package:exams_app/features/questions/data/models/question_model.dart';
import 'package:exams_app/features/questions/data/models/answer_model.dart';
import 'package:exams_app/features/questions/data/models/check_questions_response_model.dart';
import 'package:exams_app/features/questions/data/models/question_result_model.dart';
import 'package:exams_app/features/questions/data/models/exam_model.dart' as questions_exam;
import 'package:exams_app/features/authentication/api/models/forget_password_models/forget_password_response.dart';
import 'package:exams_app/features/authentication/api/models/forget_password_models/reset_password_response.dart';
import 'package:exams_app/features/authentication/api/models/forget_password_models/verify_code_response.dart';

class DummyData {
  static UserModel get user => UserModel(
        id: '1',
        username: 'John Doe',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '0123456789',
        role: 'user',
        isVerified: true,
        createdAt: DateTime.now(),
      );

  static ForgetPasswordResponse get forgetPasswordResponse =>
      ForgetPasswordResponse(message: 'Success');

  static VerifyCodeResponse get verifyCodeResponse =>
      VerifyCodeResponse(status: 'Success');

  static ResetPasswordResponse get resetPasswordResponse =>
      ResetPasswordResponse(token: 'dummy_token', message: 'Success');

  static List<SubjectModel> get subjects => [
        SubjectModel(
          id: '1',
          name: 'Mathematics',
          icon: 'https://cdn-icons-png.flaticon.com/512/3233/3233483.png',
          createdAt: DateTime.now().toIso8601String(),
        ),
        SubjectModel(
          id: '2',
          name: 'Science',
          icon: 'https://cdn-icons-png.flaticon.com/512/3063/3063999.png',
          createdAt: DateTime.now().toIso8601String(),
        ),
        SubjectModel(
          id: '3',
          name: 'History',
          icon: 'https://cdn-icons-png.flaticon.com/512/282/282161.png',
          createdAt: DateTime.now().toIso8601String(),
        ),
      ];

  static ExploreResponse get exploreResponse => ExploreResponse(
        message: 'Success',
        subjects: subjects,
      );

  static List<exams_exam.ExamModel> get exams => [
        exams_exam.ExamModel(
          id: '1',
          title: 'Midterm Math',
          duration: 60,
          subject: 'Mathematics',
          numberOfQuestions: 10,
          active: true,
          createdAt: DateTime.now().toIso8601String(),
        ),
        exams_exam.ExamModel(
          id: '2',
          title: 'Science Final',
          duration: 90,
          subject: 'Science',
          numberOfQuestions: 20,
          active: true,
          createdAt: DateTime.now().toIso8601String(),
        ),
      ];

  static ExamsResponse get examsResponse => ExamsResponse(
        message: 'Success',
        exams: exams,
      );

  static List<QuestionModel> get questions => [
        QuestionModel(
          id: '1',
          question: 'What is 2 + 2?',
          answers: [
            AnswerModel(answer: '3', key: 'A'),
            AnswerModel(answer: '4', key: 'B'),
            AnswerModel(answer: '5', key: 'C'),
            AnswerModel(answer: '6', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'B',
          exam: questions_exam.ExamModel(
            id: '1',
            title: 'Midterm Math',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '2',
          question: 'What is the capital of France?',
          answers: [
            AnswerModel(answer: 'London', key: 'A'),
            AnswerModel(answer: 'Berlin', key: 'B'),
            AnswerModel(answer: 'Paris', key: 'C'),
            AnswerModel(answer: 'Rome', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'C',
          exam: questions_exam.ExamModel(
            id: '2',
            title: 'General Knowledge',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '3',
          question: 'Which planet is known as the Red Planet?',
          answers: [
            AnswerModel(answer: 'Venus', key: 'A'),
            AnswerModel(answer: 'Mars', key: 'B'),
            AnswerModel(answer: 'Jupiter', key: 'C'),
            AnswerModel(answer: 'Saturn', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'B',
          exam: questions_exam.ExamModel(
            id: '2',
            title: 'Science Basics',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '4',
          question: 'Who wrote "Romeo and Juliet"?',
          answers: [
            AnswerModel(answer: 'Charles Dickens', key: 'A'),
            AnswerModel(answer: 'Mark Twain', key: 'B'),
            AnswerModel(answer: 'William Shakespeare', key: 'C'),
            AnswerModel(answer: 'Jane Austen', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'C',
          exam: questions_exam.ExamModel(
            id: '3',
            title: 'Literature',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '5',
          question: 'What is the square root of 64?',
          answers: [
            AnswerModel(answer: '6', key: 'A'),
            AnswerModel(answer: '7', key: 'B'),
            AnswerModel(answer: '8', key: 'C'),
            AnswerModel(answer: '9', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'C',
          exam: questions_exam.ExamModel(
            id: '1',
            title: 'Midterm Math',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '6',
          question: 'Which element has the chemical symbol "O"?',
          answers: [
            AnswerModel(answer: 'Gold', key: 'A'),
            AnswerModel(answer: 'Oxygen', key: 'B'),
            AnswerModel(answer: 'Silver', key: 'C'),
            AnswerModel(answer: 'Iron', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'B',
          exam: questions_exam.ExamModel(
            id: '2',
            title: 'Chemistry 101',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '7',
          question: 'What is the largest mammal in the world?',
          answers: [
            AnswerModel(answer: 'Elephant', key: 'A'),
            AnswerModel(answer: 'Blue Whale', key: 'B'),
            AnswerModel(answer: 'Giraffe', key: 'C'),
            AnswerModel(answer: 'Hippopotamus', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'B',
          exam: questions_exam.ExamModel(
            id: '2',
            title: 'Biology',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '8',
          question: 'In which year did World War II end?',
          answers: [
            AnswerModel(answer: '1943', key: 'A'),
            AnswerModel(answer: '1944', key: 'B'),
            AnswerModel(answer: '1945', key: 'C'),
            AnswerModel(answer: '1946', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'C',
          exam: questions_exam.ExamModel(
            id: '3',
            title: 'History',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '9',
          question: 'Which of these is NOT a prime number?',
          answers: [
            AnswerModel(answer: '2', key: 'A'),
            AnswerModel(answer: '3', key: 'B'),
            AnswerModel(answer: '4', key: 'C'),
            AnswerModel(answer: '5', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'C',
          exam: questions_exam.ExamModel(
            id: '1',
            title: 'Math Quiz',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
        QuestionModel(
          id: '10',
          question: 'What is the capital of Japan?',
          answers: [
            AnswerModel(answer: 'Beijing', key: 'A'),
            AnswerModel(answer: 'Seoul', key: 'Korea'),
            AnswerModel(answer: 'Tokyo', key: 'C'),
            AnswerModel(answer: 'Bangkok', key: 'D'),
          ],
          type: 'multiple_choice',
          correct: 'C',
          exam: questions_exam.ExamModel(
            id: '2',
            title: 'Geography',
            duration: 60,
            numberOfQuestions: 10,
          ),
        ),
      ];

  static CheckQuestionsResponseModel get checkQuestionsResponse =>
      CheckQuestionsResponseModel(
        message: 'Success',
        correct: 1,
        wrong: 1,
        total: '2',
        wrongQuestions: [
          QuestionResultModel(
            qid: '1',
            question: 'What is 2 + 2?',
            correctAnswer: '4',
            inCorrectAnswer: '3',
          ),
        ],
        correctQuestions: [
          QuestionResultModel(
            qid: '2',
            question: 'What is the capital of France?',
            correctAnswer: 'Paris',
          ),
        ],
      );
}
