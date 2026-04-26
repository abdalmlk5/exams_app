sealed class ExploreEvent {
  const ExploreEvent();
}

class GetAllSubjectsEvent extends ExploreEvent {
  const GetAllSubjectsEvent();
}

class GetFilteredSubjectsListEvent extends ExploreEvent {
  final String searchText;
  const GetFilteredSubjectsListEvent(this.searchText);
}
