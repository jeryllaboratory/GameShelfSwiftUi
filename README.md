# GameShelfSwiftUi

GameShelfSwiftUi adalah aplikasi iOS katalog game berbasis **SwiftUI**. Aplikasi ini digunakan untuk menampilkan daftar game, melihat detail game, menyimpan game favorit, dan menampilkan halaman About/Profile.

Project ini dibuat untuk submission akhir dengan fokus pada **Clean Architecture**, **Manual Dependency Injection**, **Reactive Programming menggunakan Combine**, **SwiftData** untuk penyimpanan favorite lokal, **Alamofire** untuk networking, **Swift Package Manager Modularization**, **XCTest**, **SwiftLint**, dan **Codemagic CI**.

Project sudah dipisahkan menjadi beberapa Swift Package module. Module `GameShelfCommon` sudah dipublish sebagai remote Swift Package dan digunakan melalui Swift Package Manager.

---

## Versi Build dan Environment

Project ini menggunakan versi dan environment berikut:

| Area                                | Versi / Keterangan             |
| ----------------------------------- | ------------------------------ |
| Bahasa                              | Swift 5.10                     |
| Swift Package Manager Tools Version | 5.10                           |
| Minimum Deployment Target           | iOS 17                         |
| UI Framework                        | SwiftUI                        |
| Local Storage                       | SwiftData                      |
| Build Environment                   | Xcode latest melalui Codemagic |
| Package Manager                     | Swift Package Manager          |

Catatan: seluruh `Package.swift` pada module menggunakan `// swift-tools-version: 5.10`, sehingga versi Swift yang dilampirkan untuk submission adalah **Swift 5.10** dengan minimum iOS **17**.

---

## Status Project

| Area                        | Status | Keterangan                                                               |
| --------------------------- | -----: | ------------------------------------------------------------------------ |
| SwiftUI UI                  |     ✅ | Home, Detail, Favorite, dan About/Profile tersedia.                      |
| Clean Architecture          |     ✅ | App, Core, Data, Feature, dan Common module sudah dipisahkan.            |
| Manual Dependency Injection |     ✅ | `AppDIContainer` digunakan sebagai composition root.                     |
| SwiftData Favorite Storage  |     ✅ | Favorite disimpan menggunakan SwiftData local storage.                   |
| Alamofire Networking        |     ✅ | Networking berada di `GameShelfData`.                                    |
| Reactive Programming        |     ✅ | Combine digunakan untuk search debounce dan observable state.            |
| Design Reference Applied    |     ✅ | UI disesuaikan dari mockup/reference design.                             |
| Snackbar Feedback           |     ✅ | Save/unsave favorite menggunakan snackbar feedback.                      |
| SwiftLint                   |     ✅ | `.swiftlint.yml` tersedia.                                               |
| Codemagic Config            |     ✅ | `codemagic.yaml` tersedia.                                               |
| SPM Modularization          |     ✅ | App sudah dipisah menjadi Swift Package modules.                         |
| Published Remote Module     |     ✅ | `GameShelfCommon` dipublish dan digunakan melalui Swift Package Manager. |
| Unit Tests                  |     ✅ | App tests dan package tests tersedia.                                    |
| CI Latest Pass              |     ✅ | Build terakhir Codemagic sudah berhasil.                                 |

---

## Fitur Utama

- Home screen untuk menampilkan daftar game dari remote API.
- Search game dengan debounce menggunakan Combine.
- Detail screen untuk menampilkan informasi game lengkap.
- Add/remove favorite dari Detail screen.
- Snackbar feedback saat save/unsave favorite.
- Favorite screen untuk menampilkan game favorit dari SwiftData.
- Swipe delete favorite.
- About/Profile screen untuk menampilkan biodata/profile.
- Loading, empty, dan error state.
- Pull-to-refresh pada screen yang mendukung.
- State refresh otomatis saat favorite berubah.

---

## Tech Stack

| Area                 | Teknologi                                                              |
| -------------------- | ---------------------------------------------------------------------- |
| Bahasa               | Swift                                                                  |
| UI                   | SwiftUI                                                                |
| Reactive Programming | Combine + SwiftUI state system                                         |
| State Management     | `ObservableObject`, `@Published`, `@StateObject`, `@EnvironmentObject` |
| Local Storage        | SwiftData                                                              |
| Networking           | Alamofire                                                              |
| Concurrency          | async/await                                                            |
| Architecture         | Clean Architecture                                                     |
| Dependency Injection | Manual DI dengan `AppDIContainer`                                      |
| Modularization       | Swift Package Manager                                                  |
| Testing              | XCTest                                                                 |
| Linting              | SwiftLint                                                              |
| CI                   | Codemagic                                                              |

---

## Gambaran Architecture

Project menggunakan Clean Architecture dengan alur utama:

```text
SwiftUI View
  -> ViewModel
  -> UseCase / Interactor
  -> Repository Protocol
  -> Repository Implementation
  -> Data Source
  -> Alamofire / SwiftData
```

Arah dependency:

```text
GameShelfSwiftUi App
    ├── Feature Modules
    ├── GameShelfData
    └── GameShelfCore

Feature Modules
    ├── GameShelfCore
    └── GameShelfCommon

GameShelfData
    └── GameShelfCore

GameShelfCore
    └── Tidak bergantung pada app, data, feature, atau UI modules

GameShelfCommon
    └── Tidak bergantung pada app-specific modules
```

Prinsip utama:

- `GameShelfCore` tidak bergantung pada SwiftUI, SwiftData, atau Alamofire.
- Feature modules tidak langsung mengakses data layer.
- `GameShelfData` mengimplementasikan repository protocol dari `GameShelfCore`.
- `GameShelfSwiftUi` menjadi composition root untuk navigation dan dependency injection.
- `GameShelfCommon` berisi reusable UI utilities dan tidak bergantung pada app-specific modules.

---

## Struktur Project

```text
GameShelfSwiftUi/
├─ GameShelfSwiftUi/
│  ├─ App/
│  ├─ ContentView.swift
│  └─ GameShelfSwiftUiApp.swift
├─ Modules/
│  ├─ GameShelfCommon/
│  ├─ GameShelfCore/
│  ├─ GameShelfData/
│  ├─ GameShelfHomeFeature/
│  ├─ GameShelfDetailFeature/
│  ├─ GameShelfFavoriteFeature/
│  └─ GameShelfAboutFeature/
├─ GameShelfSwiftUiTests/
├─ GameShelfSwiftUiUITests/
├─ swiftui-docs/
├─ codemagic.yaml
├─ .swiftlint.yml
├─ .gitignore
└─ README.md
```

---

## Modules

| Module                     | Jenis                | Tanggung Jawab                                                                                         |
| -------------------------- | -------------------- | ------------------------------------------------------------------------------------------------------ |
| `GameShelfSwiftUi`         | App Target           | App entry point, tab navigation, SwiftData container, dan dependency injection wiring.                 |
| `GameShelfCommon`          | Remote Swift Package | Design system, shared SwiftUI components, extensions, dan common UI utilities.                         |
| `GameShelfCore`            | Local Swift Package  | Domain entities, repository protocols, dan use cases.                                                  |
| `GameShelfData`            | Local Swift Package  | Remote data source, DTO mapping, API service, SwiftData local storage, dan repository implementations. |
| `GameShelfHomeFeature`     | Local Swift Package  | Home screen, game list, search interaction, dan home state management.                                 |
| `GameShelfDetailFeature`   | Local Swift Package  | Detail screen, detail state, dan favorite action.                                                      |
| `GameShelfFavoriteFeature` | Local Swift Package  | Favorite list screen dan favorite state management.                                                    |
| `GameShelfAboutFeature`    | Local Swift Package  | About/profile screen dan profile state management.                                                     |

---

## Published Remote Module

Project ini memenuhi syarat publish minimal satu module ke Git repository dan menggunakannya melalui dependency manager.

```text
Repository : https://github.com/jeryllaboratory/GameShelfCommon
Package    : GameShelfCommon
Product    : GameShelfCommon
Import     : import GameShelfCommon
Manager    : Swift Package Manager
Version    : 1.0.1
```

`GameShelfCommon` berisi design system tokens, shared SwiftUI components, UI state components, image loading component, search bar component, snackbar component, dan String/date formatting extension.

---

## Module Relationship Diagram

```text
                         ┌──────────────────────┐
                         │ GameShelfSwiftUi App │
                         │ Composition Root     │
                         └───────────┬──────────┘
                                     │
          ┌──────────────────────────┼──────────────────────────┐
          │                          │                          │
          ▼                          ▼                          ▼
┌──────────────────────┐  ┌──────────────────────┐  ┌──────────────────────┐
│ GameShelfHomeFeature │  │ GameShelfDetailFeature│ │ GameShelfFavoriteFeature│
│ Home Presentation    │  │ Detail Presentation   │ │ Favorite Presentation │
└──────────┬───────────┘  └──────────┬───────────┘  └──────────┬───────────┘
           │                         │                         │
           └──────────────┬──────────┴──────────────┬──────────┘
                          │                         │
                          ▼                         ▼
                 ┌─────────────────┐       ┌─────────────────┐
                 │ GameShelfCore   │       │ GameShelfCommon │
                 │ Domain Layer    │       │ Remote SPM      │
                 └─────────────────┘       └─────────────────┘

                 ┌─────────────────┐
                 │ GameShelfData   │
                 │ Data Layer      │
                 └────────┬────────┘
                          │
                          ▼
                 ┌─────────────────┐
                 │ GameShelfCore   │
                 │ Domain Layer    │
                 └─────────────────┘

Additional feature:
┌──────────────────────┐
│ GameShelfAboutFeature│
│ About Presentation   │
└──────────┬───────────┘
           ├── GameShelfCore
           └── GameShelfCommon
```

Feature modules berkomunikasi dengan domain layer melalui use case. Data layer mengimplementasikan repository protocol yang didefinisikan di `GameShelfCore`. App target melakukan dependency injection concrete implementation melalui `AppDIContainer`.

---

## Path Penting

| Area                   | Path                                                                               |
| ---------------------- | ---------------------------------------------------------------------------------- |
| App Layer              | `GameShelfSwiftUi/App/`                                                            |
| Home ViewModel         | `Modules/GameShelfHomeFeature/Sources/GameShelfHomeFeature/HomeViewModel.swift`    |
| Network Service        | `Modules/GameShelfData/Sources/GameShelfData/Remote/Services/NetworkService.swift` |
| SwiftData Local Source | `Modules/GameShelfData/Sources/GameShelfData/Local/`                               |
| Design System          | `Modules/GameShelfCommon/Sources/GameShelfCommon/DesignSystem/`                    |
| Shared Components      | `Modules/GameShelfCommon/Sources/GameShelfCommon/Components/`                      |

---

## Testing

App test targets:

```text
GameShelfSwiftUiTests/
GameShelfSwiftUiUITests/
```

Package tests:

```text
Modules/GameShelfCommon/Tests/GameShelfCommonTests
Modules/GameShelfCore/Tests/GameShelfCoreTests
Modules/GameShelfData/Tests/GameShelfDataTests
Modules/GameShelfHomeFeature/Tests/GameShelfHomeFeatureTests
Modules/GameShelfDetailFeature/Tests/GameShelfDetailFeatureTests
Modules/GameShelfFavoriteFeature/Tests/GameShelfFavoriteFeatureTests
Modules/GameShelfAboutFeature/Tests/GameShelfAboutFeatureTests
```

Test mencakup date formatting, behavior domain entity, behavior search Home, behavior DetailViewModel, behavior FavoriteViewModel, dan behavior AboutViewModel.

---

## Menjalankan Project

Buka file:

```text
GameShelfSwiftUi.xcodeproj
```

Jalankan scheme:

```text
GameShelfSwiftUi
```

Simulator yang disarankan:

```text
iPhone 16 Pro atau versi lebih baru
```

---

## Menjalankan SwiftLint

```bash
swiftlint lint --config .swiftlint.yml
```

---

## Continuous Integration

Konfigurasi Codemagic:

```text
codemagic.yaml
```

Workflow:

```text
ios-swiftui-debug
```

CI menjalankan SwiftLint, Swift package tests, app unit tests dengan code coverage, dan debug app build.

Status terakhir:

```text
Latest Codemagic build: Passed
```

---

## Criteria Checklist

| Kriteria             | Status | Keterangan                                                               |
| -------------------- | -----: | ------------------------------------------------------------------------ |
| Home page            |     ✅ | Diimplementasikan di `GameShelfHomeFeature`.                             |
| Detail page          |     ✅ | Diimplementasikan di `GameShelfDetailFeature`.                           |
| Favorite page        |     ✅ | Diimplementasikan di `GameShelfFavoriteFeature`.                         |
| About/Profile page   |     ✅ | Diimplementasikan di `GameShelfAboutFeature`.                            |
| Clean Architecture   |     ✅ | Domain, data, app, common, dan feature modules sudah dipisahkan.         |
| Dependency Injection |     ✅ | Manual DI dikelola oleh `AppDIContainer`.                                |
| Reactive Programming |     ✅ | Combine digunakan untuk search debounce dan observable state.            |
| Modularization       |     ✅ | App sudah dipisah menjadi Swift Package modules.                         |
| Published Module     |     ✅ | `GameShelfCommon` dipublish dan digunakan melalui Swift Package Manager. |
| Unit Test            |     ✅ | App tests dan package tests tersedia.                                    |
| CI                   |     ✅ | Build terakhir Codemagic sudah berhasil.                                 |
| Wireframe/Mockup     |     ✅ | Mockup referensi dan dokumentasi disediakan.                             |
| Module Diagram       |     ✅ | Diagram hubungan module dan arah dependency sudah didokumentasikan.      |
