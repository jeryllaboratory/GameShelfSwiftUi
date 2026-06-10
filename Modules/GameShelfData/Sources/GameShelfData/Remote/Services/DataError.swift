// DataError.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public enum DataError: Error, Equatable, LocalizedError {
    case invalidURL
    case notFound
    case invalidResponse
    case decodingFailed
    case emptyData

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .notFound:
            return "Data not found."
        case .invalidResponse:
            return "Unable to load data from server."
        case .decodingFailed:
            return "Unable to process server response."
        case .emptyData:
            return "No data available."
        }
    }
}
