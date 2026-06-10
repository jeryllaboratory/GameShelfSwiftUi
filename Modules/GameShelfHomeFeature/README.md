# GameShelfHomeFeature

`GameShelfHomeFeature` is the Swift Package module for the Home screen presentation layer in GameShelfSwiftUi.

## Responsibility

This package owns:

- `HomeView`
- `HomeViewModel`
- `HomeViewState`
- `HomeGameRowView`

## Dependencies

```text
GameShelfHomeFeature -> GameShelfCore
GameShelfHomeFeature -> GameShelfCommon
```

This package does not depend on:

```text
GameShelfData
GameShelfDetailFeature
GameShelfFavoriteFeature
GameShelfSwiftUi app target
```

## Navigation Rule

Home does not import Detail directly. The app target provides the detail destination through a closure:

```swift
HomeView(
    viewModel: homeViewModel,
    detailDestination: { gameId in
        DetailView(...)
    }
)
```

This keeps feature modules independent and avoids circular dependency.
