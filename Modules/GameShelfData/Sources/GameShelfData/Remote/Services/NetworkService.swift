// NetworkService.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Alamofire
import Foundation

public protocol NetworkServiceProtocol {
    func request<Response: Decodable>(_ url: URL?) async throws -> Response
}

public struct NetworkService: NetworkServiceProtocol {
    private let session: Session
    private let decoder: JSONDecoder

    public init(
        session: Session = .default,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func request<Response: Decodable>(_ url: URL?) async throws -> Response {
        guard let url else {
            throw DataError.invalidURL
        }

        let response = await session
            .request(url, method: .get)
            .validate(statusCode: 200..<300)
            .serializingData()
            .response

        switch response.result {
        case .success(let data):
            guard !data.isEmpty else {
                throw DataError.emptyData
            }

            do {
                return try decoder.decode(Response.self, from: data)
            } catch {
                throw DataError.decodingFailed
            }
        case .failure(let error):
            if error.responseCode == 404 {
                throw DataError.notFound
            }

            if error.responseCode != nil {
                throw DataError.invalidResponse
            }

            throw error
        }
    }
}
