
class Prayer {
  final String prayerTitle;
  final String? prayerExcerpt;
  final String scripture;
  final String scriptureReference;
  final String prayerMessage;
  final DateTime date;

  Prayer({required this.prayerTitle, this.prayerExcerpt, required this.scripture, required this.scriptureReference, required this.prayerMessage, required this.date});



  Prayer copyWith({
  String? prayerTitle,
  String?  prayerExcerpt,
  String? scripture,
  String? scriptureReference,
  String? prayerMessage,
  DateTime? date,
  }) {
    return Prayer(prayerTitle: prayerTitle?? this.prayerTitle, scripture: scripture??this.scripture, scriptureReference: scriptureReference??this.scriptureReference, prayerMessage: prayerMessage??this.prayerMessage, date: date??this.date);
  }

}
