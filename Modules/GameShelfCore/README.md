# GameShelfCore

`GameShelfCore` contains the domain layer for GameShelfSwiftUi.

This package owns:

- Domain entities
- Repository protocols
- Use case protocols
- Interactor implementations

## Dependency Rule

`GameShelfCore` should stay independent from UI, networking, persistence, and app composition code.

Allowed dependencies:

```text
Foundation
```

Forbidden dependencies:

```text
SwiftUI
SwiftData
Alamofire
GameShelfData
Feature modules
GameShelfSwiftUi app target
```

## Validation

Run:

```bash
swift test
```
