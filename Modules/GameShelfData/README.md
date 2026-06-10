# GameShelfData

`GameShelfData` is the data layer package for GameShelfSwiftUi.

## Responsibilities

- Remote API endpoint definitions.
- Alamofire-based network service.
- Remote data source for game list, search, and detail.
- DTO models and DTO-to-domain mapping.
- SwiftData favorite model and local data source.
- Repository implementations for Game, Favorite, and About.

## Dependency Rule

```text
GameShelfData -> GameShelfCore
GameShelfData -> Alamofire
GameShelfData -> SwiftData
```

`GameShelfData` implements repository protocols defined in `GameShelfCore`.

## Validation

```bash
swift test
```
