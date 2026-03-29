sealed class ExamsEvent {
  const ExamsEvent();
}

class GetAllExamsEvent extends ExamsEvent {
  final String? token;
  final String? subject;
  const GetAllExamsEvent({this.token, this.subject});
}
