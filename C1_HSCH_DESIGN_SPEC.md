# C1 Hochschule — Design & Architecture Specification

---

## 1. Overview

**App name:** C1 Hochschule  
**Platform:** Flutter (iOS & Android)  
**Target users:** Arabic-speaking learners preparing for the German C1 exam  
**Connectivity:** Fully offline — all content loaded from local JSON assets  
**Languages:** Arabic (AR) and German (DE) — bilingual throughout  

---

## 2. Visual Design System

### 2.1 Philosophy

- Flat and minimal — no gradients, no shadows, no decorative elements
- Every screen feels like a clean reading surface
- Color is used only to communicate meaning (correct, wrong, active, locked)
- Whitespace is the primary layout tool

### 2.2 Color Palette

| Token | Hex | Usage |
|---|---|---|
| `background` | `#FFFFFF` | All screen backgrounds |
| `surface` | `#F5F5F5` | Cards, section rows, sheet background |
| `accent` | `#378ADD` | Active blanks, letter badges, links |
| `accentLight` | `#E6F1FB` | Keyword highlights, active blank bg |
| `correct` | `#1D9E75` | Correct blank border and text |
| `correctLight` | `#E1F5EE` | Correct blank background |
| `wrong` | `#E24B4A` | Wrong blank border and text |
| `wrongLight` | `#FCEBEB` | Wrong blank background |
| `textPrimary` | `#1A1A1A` | All body text |
| `textSecondary` | `#6B6B6B` | Muted labels, hints, sub-text |
| `border` | `#E0E0E0` | Dividers, card borders, dashed blank borders |
| `locked` | `#B0B0B0` | Locked section icons and text |

### 2.3 Typography

| Role | Size | Weight | Usage |
|---|---|---|---|
| `headingLarge` | 18px | 500 | Screen titles |
| `headingMedium` | 16px | 500 | Section/model names |
| `bodyLarge` | 14px | 400 | Exercise paragraph text |
| `bodyMedium` | 13px | 400 | Option sentences in bottom sheet |
| `bodySmall` | 12px | 400 | Arabic translations, hints |
| `labelMedium` | 12px | 500 | Letter badges, counter, progress labels |
| `labelSmall` | 11px | 400 | Sub-labels, locked text |

- German text: LTR, `TextDirection.ltr`
- Arabic text: RTL, `TextDirection.rtl`
- Font: system default (San Francisco on iOS, Roboto on Android)
- Line height: 1.7× for reading areas, 1.4× for UI elements

### 2.4 Spacing & Layout

- Base unit: `8px`
- Screen horizontal padding: `16px`
- Card internal padding: `12px 16px`
- Row gap (lists): `8px`
- Section between blocks: `16px`
- All tap targets: minimum `44×44px`

### 2.5 Component Styles

**Blank (unanswered)**
- Border: `1.5px dashed #E0E0E0`
- Background: `#F5F5F5`
- Border radius: `6px`
- Min width: `36px`, height: `24px`
- Text: `…N…` in `#B0B0B0`

**Blank (active — tapped)**
- Border: `1.5px solid #378ADD`
- Background: `#E6F1FB`
- Text color: `#185FA5`

**Blank (correct)**
- Border: `1.5px solid #1D9E75`
- Background: `#E1F5EE`
- Text: chosen letter in `#085041`

**Blank (wrong)**
- Border: `1.5px solid #E24B4A`
- Background: `#FCEBEB`
- Text: chosen letter in `#791F1F`

**Keyword highlight**
- Background: `#E6F1FB`
- Text color: `#185FA5`
- Border radius: `4px`
- Padding: `0 3px`
- Rendered as `WidgetSpan` inside `Text.rich`

**Letter badge (in bottom sheet)**
- Size: `24×24px`
- Border radius: `6px`
- Background: `#E6F1FB`
- Text: `#185FA5`, 12px, weight 500

**Progress bar**
- Height: `3px`
- Background: `#E0E0E0`
- Fill: `#1D9E75`
- Animates with `AnimatedContainer`, duration `300ms`

**Feedback bar**
- Height: `48px`
- Correct: background `#E1F5EE`, text `#085041`, top border `#5DCAA5`
- Wrong: background `#FCEBEB`, text `#791F1F`, top border `#F09595`
- Slides up with `AnimatedPositioned`, auto-dismisses after `2200ms`

**Bottom sheet**
- Border radius top: `16px`
- Background: `#FFFFFF`
- Handle: `36×4px`, color `#E0E0E0`, centered
- Max height: `60%` of screen height
- Scrollable option list inside

**DE/AR toggle**
- Two-segment control: `[DE] [AR]`
- Border: `0.5px solid #E0E0E0`
- Border radius: `8px`
- Active segment: background `#E6F1FB`, text `#185FA5`
- Inactive: background transparent, text `#6B6B6B`
- Each segment: `32×28px` minimum

---

## 3. Screen Flow & Navigation

```
SectionsScreen
    └── ModelsScreen (per section)
            └── ExerciseScreen (per model)
                    └── ResultsScreen (after last blank)
```

Navigation uses `go_router`. Routes:

| Route | Screen |
|---|---|
| `/` | SectionsScreen |
| `/section/:sectionId` | ModelsScreen |
| `/exercise/:sectionId/:modelId` | ExerciseScreen |
| `/results/:sectionId/:modelId` | ResultsScreen |

Pass only IDs in routes. Screens fetch their own data via Riverpod providers.

---

## 4. Screen Specifications

### 4.1 SectionsScreen

**Layout (top to bottom):**
1. App bar — app name "C1 Hochschule" (left), no actions
2. Vertical list of 8 section rows

**Section row:**
- Left: circle with section number (24px, accent background)
- Center: section name (headingMedium) + model count below (bodySmall, textSecondary)
- Right: chevron icon if unlocked, lock icon if locked
- Locked rows: 40% opacity on name and count

**Interaction:**
- Tap unlocked row → navigate to ModelsScreen
- Tap locked row → no action (or subtle "not available yet" snackbar)

---

### 4.2 ModelsScreen

**Layout (top to bottom):**
1. App bar — section name (left), back arrow (right in RTL, left in LTR)
2. Vertical list of model rows

**Model row:**
- Left: model number (labelMedium, textSecondary)
- Center: model name (bodyLarge)
- Right: green checkmark + score if completed, "جديد" badge if next, nothing if locked

**Interaction:**
- Tap any unlocked model → navigate to ExerciseScreen

---

### 4.3 ExerciseScreen

**Layout (top to bottom):**
1. Top bar
2. Progress bar (3px, full width, no padding)
3. Scrollable reading area
4. Translation button (fixed below reading area)
5. Bottom sheet (overlays screen when open)
6. Feedback bar (overlays bottom when visible)

**Top bar:**
- Left: back arrow + model name (headingMedium)
- Right: blank counter (`answered / total`) + DE/AR toggle
- Background: white, bottom border `0.5px #E0E0E0`

**Reading area:**
- Full German paragraph built as `Text.rich`
- `TextSegment` → plain `TextSpan`, color `textPrimary`
- `KeywordSegment` → `WidgetSpan` with blue highlight box
- `BlankSegment` → `WidgetSpan` with `GestureDetector`, styled by answer state
- Arabic translation paragraph shown below a `Divider` when translation is ON
- Arabic paragraph uses the same segment builder with `TextDirection.rtl`
- Blank positions in Arabic paragraph shown as static colored markers (not tappable)

**Translation button:**
- Full width, outlined style
- Label (DE mode): "ترجمة النص والأجوبة"
- Label (AR mode): "إخفاء الترجمة" when translation is visible
- Icon: `language` icon (left of label)
- On tap: toggles `showTranslation` in state

**Bottom sheet (on blank tap):**
- Header: "فراغ N — اختر الجملة المناسبة" + X close button
- Option list: `ListView` of option rows, filtered to exclude already-used keys
- Option row: letter badge + German sentence + (if showTranslation) Arabic sentence below in textSecondary
- Keywords inside option sentences rendered in accent color, weight 500
- On option tap: call `notifier.selectAnswer(blankId, key)`, sheet closes

**Feedback bar:**
- Slides up from bottom over the content (not above the bottom sheet)
- Correct: "✓ ممتاز! إجابة صحيحة"
- Wrong: "✗ الجواب الصحيح: [key]"
- Auto-dismisses after 2200ms

---

### 4.4 ResultsScreen

**Layout (top to bottom):**
1. App bar — "النتيجة" (left), no back arrow
2. Score card (centered)
3. Breakdown list — one row per blank
4. Retry button (bottom)

**Score card:**
- Large score number: `correct / total` (headingLarge, 32px)
- Sub-label: "إجابات صحيحة" (bodySmall, textSecondary)
- Background surface, border radius 12px, padding 24px

**Breakdown row:**
- Blank number (labelMedium)
- Chosen answer key — green if correct, red if wrong
- Correct answer key (shown only if answer was wrong)
- Short German sentence of the correct option (bodySmall, textSecondary, max 1 line)

**Retry button:**
- Full width, accent background
- Label: "إعادة المحاولة"
- On tap: reset exercise state, navigate back to ExerciseScreen

---

## 5. Architecture

### 5.1 Pattern — Feature-First Clean Architecture

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_spacing.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── result.dart          # Result<T> sealed class
│   │   └── extensions.dart
│   └── widgets/
│       ├── blank_span.dart
│       ├── keyword_span.dart
│       ├── feedback_bar.dart
│       └── progress_bar.dart
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── section_repository.dart
│   │   │   └── section_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── section.dart
│   │   │   └── model_meta.dart
│   │   └── presentation/
│   │       ├── sections_screen.dart
│   │       ├── sections_notifier.dart
│   │       ├── models_screen.dart
│   │       └── models_notifier.dart
│   └── exercise/
│       ├── data/
│       │   ├── exercise_repository.dart
│       │   ├── exercise_repository_impl.dart
│       │   └── json_parser.dart
│       ├── domain/
│       │   ├── exercise.dart
│       │   ├── segment.dart
│       │   ├── option.dart
│       │   └── blank_answer.dart
│       └── presentation/
│           ├── exercise_screen.dart
│           ├── exercise_notifier.dart
│           ├── exercise_state.dart
│           ├── results_screen.dart
│           └── widgets/
│               ├── reading_area.dart
│               ├── translation_button.dart
│               ├── answer_bottom_sheet.dart
│               └── blank_widget.dart
├── l10n/
│   ├── app_ar.arb
│   └── app_de.arb
└── main.dart

assets/
└── data/
    ├── s1_m1_maus_gold.json
    ├── s1_m2_rechtschreibung.json
    └── ...
```

### 5.2 Layer Responsibilities

**`domain/`**
- Pure Dart only — zero Flutter imports
- Immutable entities using `@freezed`
- No JSON logic, no async, no state

**`data/`**
- Loads and parses JSON from `rootBundle`
- Returns `Result<T>` — never throws to UI
- Caches parsed exercises in memory after first load
- Repository interface in `data/`, implementation also in `data/`

**`presentation/`**
- Screens read state and call notifier methods only
- Zero business logic inside widgets
- All Notifiers extend `StateNotifier<T>` from Riverpod
- State classes are `@freezed`

**`core/`**
- Shared across all features
- No feature-specific logic
- `result.dart` defines `Result<T>` as a sealed class:
  ```dart
  sealed class Result<T> {
    const factory Result.ok(T value)        = Ok<T>;
    const factory Result.err(String message) = Err<T>;
  }
  ```

---

## 6. State Management — Riverpod

### 6.1 Providers tree

```dart
// Repositories — created once, shared
final exerciseRepositoryProvider = Provider<ExerciseRepository>(...);

// Per-exercise session — family by (sectionId, modelId)
final exerciseProvider = StateNotifierProvider.family<
  ExerciseNotifier, ExerciseState, (int, int)
>((ref, ids) => ExerciseNotifier(ref.read(exerciseRepositoryProvider), ids));
```

### 6.2 ExerciseState

```dart
@freezed
class ExerciseState with _$ExerciseState {
  const factory ExerciseState({
    required AsyncValue<Exercise> exercise,
    @Default({}) Map<int, String> selectedAnswers,  // blankId → chosenKey
    int? activeBlankId,
    @Default(false) bool showTranslation,
    @Default('de') String lang,                      // 'de' | 'ar'
    @Default(false) bool showFeedback,
    @Default(true) bool lastAnswerCorrect,
    @Default(false) bool isFinished,
  }) = _ExerciseState;
}
```

### 6.3 ExerciseNotifier methods

```dart
void loadExercise()
void openBlank(int blankId)
void closeBlank()
void selectAnswer(int blankId, String key)
void toggleTranslation()
void setLang(String lang)        // 'de' | 'ar'
void retry()
```

`selectAnswer` handles: recording answer, checking correctness, triggering feedback bar, auto-dismissing feedback after 2200ms via `Future.delayed`, advancing counter, and checking if exercise is finished.

---

## 7. Data Layer — JSON Format

File naming: `s{section}_m{model}_{slug}.json`  
Location: `assets/data/`  
Must be declared in `pubspec.yaml` under `flutter > assets`.

### 7.1 JSON structure

```json
{
  "meta": {
    "app": "c1_hsch",
    "section": 1,
    "section_name": "LV1",
    "model": 1,
    "model_name": "Maus",
    "level": "C1",
    "total_blanks": 6
  },
  "text": {
    "de": [
      {
        "type": "paragraph",
        "segments": [
          { "type": "text",    "content": "..." },
          { "type": "keyword", "content": "Tastaturanschläge" },
          { "type": "blank",   "id": 1 },
          { "type": "text",    "content": "..." }
        ]
      }
    ],
    "ar": [ ... ]
  },
  "answers": [
    {
      "id": 1,
      "correct_key": "E",
      "options": [
        {
          "key": "E",
          "de": "Jetzt wird nämlich nicht nur die Tastatur...",
          "ar": "الآن لا تمثّلنا لوحة المفاتيح فحسب...",
          "keywords": { "de": "Tastatur", "ar": "لوحة المفاتيح" }
        }
      ]
    },
    { "id": 2, "correct_key": "B" },
    { "id": 3, "correct_key": "H" },
    { "id": 4, "correct_key": "C" },
    { "id": 5, "correct_key": "G" },
    { "id": 6, "correct_key": "D" }
  ]
}
```

The `options` array lives under blank `id: 1` only and is the shared pool for all blanks. The parser extracts it once and attaches it to the `Exercise` entity.

---

## 8. Localization

Two ARB files under `lib/l10n/`:

**Strings to localize (both files):**

| Key | AR | DE |
|---|---|---|
| `appName` | C1 Hochschule | C1 Hochschule |
| `sectionsTitle` | الأقسام | Abschnitte |
| `modelsTitle` | النماذج | Modelle |
| `blankCounter` | `{current} / {total}` | `{current} / {total}` |
| `translateBtn` | ترجمة النص والأجوبة | Text übersetzen |
| `hideTranslateBtn` | إخفاء الترجمة | Übersetzung ausblenden |
| `sheetTitle` | فراغ {n} — اختر الجملة | Lücke {n} — Wähle den Satz |
| `feedbackCorrect` | ممتاز! إجابة صحيحة | Richtig! |
| `feedbackWrong` | الجواب الصحيح: {key} | Richtige Antwort: {key} |
| `resultsTitle` | النتيجة | Ergebnis |
| `correctAnswers` | إجابات صحيحة | Richtige Antworten |
| `retryBtn` | إعادة المحاولة | Nochmal versuchen |
| `lockedSection` | غير متاح بعد | Noch nicht verfügbar |
| `newBadge` | جديد | Neu |

The DE/AR toggle controls **content language** (which text segments to render), not the app UI locale. UI locale is set once at app start based on device locale, defaulting to Arabic.

---

## 9. Clean Code Rules

- One class per file, snake_case filename matching class name
- No `setState` outside trivial animation controllers
- No `dynamic` anywhere — all JSON uses generated `fromJson`
- No raw `Exception` reaching UI — all errors via `Result.err`
- No business logic in widget `build` methods
- Max method length: 20 lines — extract to private methods beyond that
- All entities `@freezed` — immutable, `copyWith`, `==`, `hashCode` for free
- Barrel `index.dart` per feature folder for clean imports
- No hardcoded strings in widgets — all through `AppLocalizations` or content layer
- Repository always returns cached result on second call — no re-parsing assets

---

## 10. Packages

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

No HTTP packages. No local database — JSON files in assets are the single source of truth.

