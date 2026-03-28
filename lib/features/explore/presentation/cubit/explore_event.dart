sealed class ExploreEvent {
  const ExploreEvent();
}

class GetAllSubjectsEvent extends ExploreEvent {
  final String token;
  const GetAllSubjectsEvent(this.token);
}
