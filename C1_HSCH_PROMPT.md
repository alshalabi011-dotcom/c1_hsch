# C1 Hochschule — Flutter App Prompt

You are a senior Flutter developer and mobile UI designer.
Build the complete **C1 Hochschule** app exactly as described in the design and architecture specification below. Do not deviate from any decision in the spec. If something is not specified, choose the simplest option consistent with the existing decisions.

---

## Spec reference

Follow `C1_HSCH_DESIGN_SPEC.md` in full. Key decisions summarized here — the spec is authoritative on all details.

---

## Visual design — non-negotiable rules

Use only the color tokens defined in Section 2.2 of the spec. Do not introduce any color not in that table.

```dart
class AppColors {
  static const background    = Color(0xFFFFFFFF);
  static const surface       = Color(0xFFF5F5F5);
  static const accent        = Color(0xFF378ADD);
  static const accentLight   = Color(0xFFE6F1FB);
  static const correct       = Color(0xFF1D9E75);
  static const correctLight  = Color(0xFFE1F5EE);
  static const wrong         = Color(0xFFE24B4A);
  static const wrongLight    = Color(0xFFFCEBEB);
  static const textPrimary   = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const border        = Color(0xFFE0E0E0);
  static const locked        = Color(0xFFB0B0B0);
}
```

No gradients. No shadows. No decorative elements. No Material elevation.
All tap targets minimum 44×44px.
Base spacing unit is 8px. Screen horizontal padding is 16px.
Typography scale as defined in Section 2.3 — body text 14px / 1.7 line height for reading areas.

Component visual rules (blanks, keywords, letter badges, progress bar, feedback bar, bottom sheet, DE/AR toggle) are fully specified in Section 2.5 — implement them exactly.

---

## Screen flow

```
SectionsScreen → ModelsScreen → ExerciseScreen → ResultsScreen
```

Navigation via `go_router`. Routes: `/`, `/section/:sectionId`, `/exercise/:sectionId/:modelId`, `/results/:sectionId/:modelId`. Screens receive only IDs from the route and fetch their own data via providers.

All four screens are fully specced in Section 4 of the spec. Implement each screen exactly as described — layout, components, interactions, edge cases.

---

## Architecture

Feature-first clean architecture. Folder structure exactly as in Section 5.1 of the spec.

**Layer rules — enforced:**
- `domain/` — pure Dart only, zero Flutter imports, all entities `@freezed`
- `data/` — JSON loading via `rootBundle`, memory cache after first parse, returns `Result<T>` sealed class, never throws to UI
- `presentation/` — screens and widgets read state and call notifier methods only, zero business logic

`Result<T>` sealed class:
```dart
sealed class Result<T> {
  const factory Result.ok(T value)         = Ok<T>;
  const factory Result.err(String message) = Err<T>;
}
```

---

## State management — Riverpod

`StateNotifier` + `@freezed` state for all screens. No `setState` except trivial animation controllers.

`ExerciseState` fields (Section 6.2):
- `AsyncValue<Exercise> exercise`
- `Map<int, String> selectedAnswers`
- `int? activeBlankId`
- `bool showTranslation`
- `String lang` — `'de'` or `'ar'`
- `bool showFeedback`
- `bool lastAnswerCorrect`
- `bool isFinished`

`ExerciseNotifier` methods (Section 6.3):
`loadExercise`, `openBlank`, `closeBlank`, `selectAnswer`, `toggleTranslation`, `setLang`, `retry`.

`selectAnswer` must: record answer, check correctness, trigger feedback bar, auto-dismiss after 2200ms via `Future.delayed`, increment counter, check if finished.

Exercise provider is a `StateNotifierProvider.family` keyed by `(sectionId, modelId)`.

---

## Exercise screen — critical implementation details

Build the German paragraph as `Text.rich`. Map each segment type:
- `TextSegment` → `TextSpan` with `textPrimary`
- `KeywordSegment` → `WidgetSpan` containing a styled container: background `accentLight`, text color `#185FA5`, border-radius 4px, padding `0 3px`
- `BlankSegment` → `WidgetSpan` containing a `GestureDetector` wrapped blank widget — style driven by answer state (unanswered / active / correct / wrong) as defined in Section 2.5

Arabic translation paragraph uses the same segment builder with `TextDirection.rtl`. Blank positions in the Arabic paragraph are static non-tappable markers.

Bottom sheet opens via `showModalBottomSheet`. Option list is a `ListView` filtered to exclude already-used answer keys. If `showTranslation` is true, each option row shows the Arabic sentence below the German sentence in `textSecondary`.

Feedback bar uses `AnimatedPositioned` at the bottom of the exercise screen stack. It is independent of the bottom sheet z-order.

DE/AR toggle (top bar) controls `state.lang` only — it does not change device locale. It affects which content segments render (de vs ar paragraphs) and the direction of text inside the exercise.

---

## Data — JSON format

Spec Section 7.1 defines the exact JSON structure. Implement `fromJson` for all entities using `json_serializable`. The `options` array appears only under blank `id: 1` in the JSON — the parser extracts it once and sets it on the `Exercise` entity as the shared pool.

File naming: `s{section}_m{model}_{slug}.json` under `assets/data/`.

---

## Localization

Two ARB files: `lib/l10n/app_ar.arb` and `lib/l10n/app_de.arb`. All strings from the table in Section 8 must be present in both files. No hardcoded user-facing strings in widgets.

---

## Clean code — enforced

- One class per file, snake_case filename
- No `dynamic` — all JSON via generated `fromJson`
- No raw exceptions to UI — `Result.err` only
- No logic in widget `build` — notifier methods only
- Max method length 20 lines
- Barrel `index.dart` per feature folder
- Repository caches on first load — no re-parsing on hot reload or re-navigation

---

## Packages

```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  go_router: ^13.2.0

dev_dependencies:
  build_runner: ^2.4.9
  freezed: ^2.5.2
  json_serializable: ^6.8.0
```

No HTTP. No local database. JSON assets are the single source of truth.

