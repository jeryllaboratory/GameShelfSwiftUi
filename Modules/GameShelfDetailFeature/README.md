# GameShelfDetailFeature

`GameShelfDetailFeature` is the Swift Package module for the GameShelf detail screen.

## Responsibility

This package owns Detail presentation logic:

- `DetailView`
- `DetailViewModel`
- `DetailViewState`
- `DetailHeaderView`
- `DetailInfoGridView`
- `DetailFavoriteButton`

## Dependencies

```text
GameShelfDetailFeature
├─ GameShelfCore
└─ GameShelfCommon
```

## Rule

This package must not depend on:

```text
GameShelfData
GameShelfHomeFeature
GameShelfFavoriteFeature
GameShelfAboutFeature
GameShelfSwiftUi App
```

The main app remains responsible for dependency injection and navigation.
