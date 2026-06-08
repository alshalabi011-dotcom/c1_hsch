/// General-purpose extensions used across the app.
extension StringExtension on String {
  /// Capitalizes the first character of the string.
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

extension ListExtension<T> on List<T> {
  /// Returns null if the list is empty, otherwise the first element.
  T? get firstOrNull => isEmpty ? null : first;
}
