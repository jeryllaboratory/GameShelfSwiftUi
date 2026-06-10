// AppDIContainer.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfAboutFeature
import GameShelfCore
import GameShelfData
import GameShelfDetailFeature
import GameShelfFavoriteFeature
import GameShelfHomeFeature
import SwiftData

@MainActor
final class AppDIContainer: ObservableObject {
    @Published private(set) var favoriteRefreshToken = UUID()

    private let modelContext: ModelContext
    private let networkService: GameShelfData.NetworkServiceProtocol

    init(
        modelContext: ModelContext,
        networkService: GameShelfData.NetworkServiceProtocol = GameShelfData.NetworkService()
    ) {
        self.modelContext = modelContext
        self.networkService = networkService
    }

    func notifyFavoriteChanged() {
        favoriteRefreshToken = UUID()
    }

    func makeGameRepository() -> GameShelfCore.GameRepositoryProtocol {
        let remoteDataSource = GameShelfData.GameRemoteDataSource(networkService: networkService)
        return GameShelfData.GameRepository(remoteDataSource: remoteDataSource)
    }

    func makeFavoriteRepository() -> GameShelfCore.FavoriteRepositoryProtocol {
        let localDataSource = GameShelfData.FavoriteLocalDataSource(modelContext: modelContext)
        return GameShelfData.FavoriteRepository(localDataSource: localDataSource)
    }

    func makeAboutRepository() -> GameShelfCore.AboutRepositoryProtocol {
        GameShelfData.AboutRepository()
    }

    func makeHomeUseCase() -> GameShelfCore.HomeUseCase {
        GameShelfCore.HomeInteractor(repository: makeGameRepository())
    }

    func makeDetailUseCase() -> GameShelfCore.DetailUseCase {
        GameShelfCore.DetailInteractor(
            gameRepository: makeGameRepository(),
            favoriteRepository: makeFavoriteRepository()
        )
    }

    func makeFavoriteUseCase() -> GameShelfCore.FavoriteUseCase {
        GameShelfCore.FavoriteInteractor(repository: makeFavoriteRepository())
    }

    func makeAboutUseCase() -> GameShelfCore.AboutUseCase {
        GameShelfCore.AboutInteractor(repository: makeAboutRepository())
    }

    func makeHomeViewModel() -> GameShelfHomeFeature.HomeViewModel {
        GameShelfHomeFeature.HomeViewModel(useCase: makeHomeUseCase())
    }

    func makeDetailViewModel(gameId: Int) -> GameShelfDetailFeature.DetailViewModel {
        GameShelfDetailFeature.DetailViewModel(
            gameId: gameId,
            useCase: makeDetailUseCase(),
            onFavoriteChanged: { [weak self] in
                self?.notifyFavoriteChanged()
            }
        )
    }

    func makeFavoriteViewModel() -> GameShelfFavoriteFeature.FavoriteViewModel {
        GameShelfFavoriteFeature.FavoriteViewModel(useCase: makeFavoriteUseCase())
    }

    func makeAboutViewModel() -> GameShelfAboutFeature.AboutViewModel {
        GameShelfAboutFeature.AboutViewModel(useCase: makeAboutUseCase())
    }
}

extension AppDIContainer {
    static var preview: AppDIContainer {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(
                for: GameShelfData.FavoriteGameModel.self,
                configurations: configuration
            )
            return AppDIContainer(modelContext: container.mainContext)
        } catch {
            preconditionFailure("Failed to create preview ModelContainer: \(error)")
        }
    }
}
