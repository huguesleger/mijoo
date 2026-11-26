# Coding rules

## Use a clean code architecture where
  - each feature is implemented in /lib/features/feature_name
  - separate data, domain and presentation layers as sub directories
  - data directory contains data sources and mappers and repositories implementations
  - domain directory contains domains entities and repositories definition
  - presentation directory contains flutter widgets and presentation logic
  - no use case layer by default: the cubit calls the repository directly. A use case is justified only when a business action is reused by several cubits or screens, or when composing several repositories is not trivial

## Presentation layer
  - Use Flutter Bloc cubit for state management and presentation logic
  - Divide a presentation screen into multiple widgets
    - A feature page route which provides the cubit for the screen and define the go_router page route named `<feature>_page_route.dart`. The cubit is provided by the page route, never by a `BlocProvider` inside the screen
    - A feature screen which defines the layout of the screen named `<feature>_screen.dart` (under 150 lines)
    - The screen widget should only define the layout of the screen and delegate the detail presentation to other widgets (header, content, footer, etc...)
    - Other widgets which define semantic parts of the screen (avoid a widget with more than 100 lines of code)
  - In new code, one public widget per file, the file named after the class in snake_case. No private widget and no `Widget _buildX()` method: extract a public widget instead (only the `_XxxState` of a `StatefulWidget` stays private)
  - Prefer `StatelessWidget`
  - Use BlocBuilder to build the screen based on the state of the cubit, with an exhaustive switch expression on the state. No `if (state is X)` followed by a cast
  - A model (entity, state, route extra, sealed configuration type) only carries data and derives data from it (`int get people` on `HouseholdProfile`). It never takes a UI decision: no getter that says which step to show or hide, where to navigate, or which wording to display (`showsBudgetStep`, `goesToHome`). The widget takes that decision from the data: an exhaustive switch on the case, or a read of the `Option` (`isNone()` shows the step)
  - A UI decision with more than two outcomes (several possible returns after a success) is an exhaustive switch on a sealed type or an enum, never a `bool`
  - Never put a view model in the screen facts (`XxxFacts`, the raw data the presentation rules read), nor a fact in a view model, even when their fields are identical: the facts get their own type, and a pure rule function converts them into view models

## Design system and screen states
  - Build the UI with the components of `lib/core_ui/` (prefixed `Mj`, short for Mijoo) and its tokens (`MjColors`, `MjSpacing`, `MjRadius`, `MjTextStyles`, `MjTheme`), never with raw colors, sizes or text styles. Titles use Fredoka (`MjTextStyles.headline`, `MjTextStyles.display`), the other texts use Comfortaa through the theme. A reusable component belongs in `lib/core_ui/`, which never imports anything from the rest of the app (checked by `test/core_ui/core_ui_boundaries_test.dart`)
  - Every class of the design system starts with `Mj` and lives in a file starting with `mj_` (`MjCard` in `mj_card.dart`). The classes of the features never use this prefix
  - Pages:
    - `MjHeroPage` for the welcome screen on the pink and lilac gradient
    - `MjSheetPage` for the screens with a gradient header and a white sheet (sign in, register, forgot password, household setup), its title is a `MjHeader`
    - `MjPage` for the plain screens and the tabs; a tab starts with a `MjTabHeader` whose actions are `MjRoundIconButton`s
  - Forms use `MjTextField`, `MjPasswordField`, `MjSearchField`, `MjCounter`, `MjChoiceChip` and `MjCheckChip`. The main action is a `FilledButton` (ink pill of the theme), a secondary link is a `MjLinkPrompt` or a `TextButton`
  - Loading:
    - A list read from Firestore shows its real view filled with a bone mock inside `MjSkeletonizer`. The bone mock is a top-level value in `<feature>_bone_mock.dart`, in the presentation layer, never in the state
    - Any other wait (sending a form, signing out) shows `MjLoader`
    - So that the skeleton or the loader does not flash, the cubit waits `MjSkeletonizer.minDuration` before showing the first data of a stream, and wraps a `TaskEither` shown with a loader in `withMinimalDelay(MjLoader.minDuration)`. A silent write while the data stays on screen never waits. The duration is injected (`Duration? minimalLoading`) and the tests pass `Duration.zero`
  - Empty states and messages use `MjMessageView`: the default `MjMessagePlacement.card` inside a form or a list, `MjMessagePlacement.tab` for the empty state of a whole tab, with an optional title, icon and `MjMessageAction`
  - A failure state carries its `AppFailure` (`XxxFailed(this.failure)`) and the screen shows it with `FailureView`. The wording of each failure lives in `failureMessage` (`lib/core/presentation/failure_message.dart`): a new failure that can reach a screen gets its message there
  - A modal bottom sheet is opened with `MjBottomSheet.show` and its content is a `MjBottomSheet`. The sheet only returns its result (a sealed type, such as `FridgeSheetSaved` / `FridgeSheetDeleted`): the cubit of the screen performs the action
  - Data read from Firestore is followed in real time through a stream: no pull to refresh

## State
  - Model the state as a sum type: an `@immutable sealed class` with variants (`final class` in new code) (`Initial`, `Loading`, `Loaded`, `Error`...), never a class with nullable fields and status flags
  - Use a sealed class when the variants carry data, an enum when they carry none, a record for a local composite value
  - The state lives in `xxx_state.dart`, declared `part of 'package:<package>/…/xxx_cubit.dart';` (full package path, see Imports)
  - Data shared by every variant becomes a required field of the sealed parent
  - No `Equatable` and no `freezed` on states or domain entities (`AppFailure` is the only `Equatable`)
  - `copyWith` may evolve a variant that carries independent fields, never switch from one variant to another: build the new variant
  - Always use SafeCubit instead of Cubit
  - Inject dependencies through the constructor with a fallback on the service locator (`repository ?? getIt.get<Repository>()`)

## Functional Programming
  - Use fpdart for functional programming
  - Use `Option<T>` instead of nullable types in the domain and as soon as a value enters a `map` / `flatMap` / `match` chain. A nullable is only acceptable for a value consumed immediately for display (`Text(maybe ?? '')`)
  - A sealed type whose variants only say whether a value is present (`NoX` / `X(value)`) is an `Option<T>`: do not write it. Two values that play the same role side by side (the household of the session and the household given to the setup) get the same type and the same naming
  - Use `TaskEither<AppFailure, T>` for every I/O operation which may fail
  - `AppFailure` is an `abstract class` extending `Equatable`, never sealed: each package defines its own failures
  - Always compose operations in multiple simple ways (`map`, `flatMap`, Do notation beyond two steps)
```dart
  // DON'T
  someRepo
    .loadSomething()
    .match(
      (_) => emit(ErrorState()),
      (success) => emit(SuccessState(success)),
    )
    .run();

  // DO
  someRepo
    .loadSomething()
    .match(
      (_) => ErrorState(),
      SuccessState.new,
    )
    .map(emit)
    .run();
```
  - `match` takes the failure case first, then the success case; pass constructors and `emit` as tear-offs
  - The cubits are responsible to run the operations at the end: `.run()` is the last link, never called in a repository nor in the middle of a method
  - Use match instead of fold
  - No `try/catch` in domain or presentation. In data, only `TaskEither.tryCatch`, whose `onError` logs and returns an `AppFailure` and never throws
  - A repository implementation only delegates to the data source and maps the DTO to the entity: no business logic, no `try/catch`, no `.run()`
  - Mappers are free functions named `<source>To<Target>` in `<entity>_mapper.dart`. An enum mapper extension is declared on the non-nullable type
  - A business identifier does not cross the domain as a raw `String`: use a dedicated `extension type`

## Imports
  - Always use the full package path for every `import`, `export`, `part` and `part of` (`import 'package:mijoo/core_ui/core_ui.dart';`, `import 'package:mijoo/features/auth/domain/auth_repository.dart';`), never a relative path such as `'../../../core_ui/ds_tokens.dart'` or `'auth_state.dart'`. The `always_use_package_imports` lint enforces it for imports
  - Only the paths a generator requires stay as it writes them: the generated files themselves, and `part 'routes.g.dart';` that `go_router_builder` needs in `routes.dart`
  - A file under `test/` has no package path: the shared test helpers live in `test/helpers/` and the tests import them with a relative path (`import '../../../helpers/pump_app.dart';`)

## Code style
  - Never use a default case in a switch on a sealed class: it hides the compile error when a variant is added
  - Use switch expressions instead of switch statements
  - Prefer to use expressions instead of statements
  - Use a ternary or a switch expression to choose a value instead of if-else. An `if` stays for a side effect
  - In new application code, naming replaces comments: no `//` nor `///` comments (the foundations of `lib/core/` keep their `///` documentation)
  - No `print`
  - Never edit generated files (`*.g.dart`, `*.gen.dart`): regenerate them
  - No user-visible text written in the Dart code of the apps: it lives in the feature's `*_fr.i18n.json` (slang) and is read with `t.<namespace>.<key>`. Parameters use braces (`{count}`). Do not use slang plurals: keep the choice in Dart with separate keys (`zero`, `single`, `several`)
  - Never write an asset path by hand: use the generated `Assets` class of `core_ui`
  - Run `flutter` and `dart` through `fvm`

## Tests
  - Test cubits with `bloc_test` and mock the interface of the repository or use case with `mocktail`, never the implementation
  - Stub a `TaskEither` with `thenReturn(TaskEither.right(value))` and use `UnknownFailure()` or the typed domain failure, never a mock of `AppFailure`
  - The test file mirrors the path of the tested file under `test/`
