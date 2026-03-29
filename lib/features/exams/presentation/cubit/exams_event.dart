sealed class ExamsEvent {
  const ExamsEvent();
}

class GetAllExamsEvent extends ExamsEvent {
  final String token;
  const GetAllExamsEvent(this.token);
}
