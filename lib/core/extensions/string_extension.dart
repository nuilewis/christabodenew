///An extension to the String type which creates a [Title Case] capitalisation
///on all string, by first splitting each string into the constituent words, then capitalising the
///the first letter of the word, then joining the string again.
///
/// Will return an empty string if the initial string is empty.

extension TitleCase on String {
  String toCapitalized() =>
      length > 0 ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}" : "";
  String toTitleCase() => replaceAll(RegExp(" +"), " ")
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}
