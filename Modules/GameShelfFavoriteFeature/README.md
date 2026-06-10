# GameShelfFavoriteFeature

`GameShelfFavoriteFeature` is the Swift Package module for the Favorite screen in GameShelfSwiftUi.

## Responsibility

This package owns Favorite presentation logic:

- `FavoriteView`
- `FavoriteViewModel`
- `FavoriteViewState`
- `FavoriteGameRowView`

## Dependencies

```text
GameShelfFavoriteFeature -> GameShelfCore
GameShelfFavoriteFeature -> GameShelfCommon
```

This package must not depend on:

```text
GameShelfData
GameShelfHomeFeature
GameShelfDetailFeature
GameShelfAboutFeature
GameShelfSwiftUi app target
```

## Navigation Rule

Favorite does not import Detail directly. Detail navigation is provided by the app composition root using a closure:

```swift
FavoriteView(
    viewModel: favoriteViewModel,
    detailDestination: { gameId in
        DetailView(...)
    }
)
```
