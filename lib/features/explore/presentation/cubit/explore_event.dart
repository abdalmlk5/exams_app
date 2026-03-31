sealed class ExploreEvent {
  const ExploreEvent();
}

class GetAllSubjectsEvent extends ExploreEvent {
  final String token;
  const GetAllSubjectsEvent(this.token);
}

class GetFilteredSubjectsListEvent extends ExploreEvent {
  final String searchText;
  const GetFilteredSubjectsListEvent(this.searchText);
}
