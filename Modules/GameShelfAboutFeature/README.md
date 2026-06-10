# GameShelfAboutFeature

`GameShelfAboutFeature` is the Swift Package module for the About/Profile screen in GameShelfSwiftUi.

## Responsibility

This package owns About presentation logic:

- `AboutView`
- `AboutViewModel`
- `AboutViewState`
- `AboutProfileHeaderView`
- `AboutStatCardView`
- `AboutBiographyCardView`
- `AboutExpertiseView`

## Dependencies

```text
GameShelfAboutFeature -> GameShelfCore
GameShelfAboutFeature -> GameShelfCommon
```

This package must not depend on:

```text
GameShelfData
GameShelfHomeFeature
GameShelfDetailFeature
GameShelfFavoriteFeature
GameShelfSwiftUi app target
```
