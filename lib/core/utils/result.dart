/// A sealed Result type used throughout the data layer.
/// The data layer never throws — it returns Result.err instead.
sealed class Result<T> {
  const Result._();

  const factory Result.ok(T value) = Ok<T>;
  const factory Result.err(String message) = Err<T>;

  /// Returns true if this is an Ok result.
  bool get isOk => this is Ok<T>;

  /// Returns true if this is an Err result.
  bool get isErr => this is Err<T>;

  /// Pattern-match helper. Exactly one of [ok] or [err] is called.
  R when<R>({
    required R Function(T value) ok,
    required R Function(String message) err,
  }) {
    return switch (this) {
      Ok<T>(:final value) => ok(value),
      Err<T>(:final message) => err(message),
    };
  }
}

final class Ok<T> extends Result<T> {
  const Ok(this.value) : super._();
  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.message) : super._();
  final String message;
}
