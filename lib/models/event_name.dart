class Event {
  final String eventName;
  final String eventDescription;
  final DateTime startDate;
  final DateTime? endDate;

  Event(
      {required this.eventName,
      required this.eventDescription,
      required this.startDate,
      this.endDate});

  Event copyWith({
    String? eventName,
    String? eventDescription,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Event(
        eventName: eventName ?? this.eventName,
        eventDescription: eventDescription ?? this.eventDescription,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }
}
