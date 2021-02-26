//
//  RickAndMortyData.swift
//  RickAndMorty
//
//  Created by cole cabral on 2021-01-28.
//

import Foundation

struct RickAndMorty: Codable {
    let info: Info
    let results: [Result]
}

struct Info: Codable {
    let count, pages: Int /// page number count and count
    let next: String? /// next url string
    let prev: String? /// previous url string
}

struct Result: Codable {
    let id: Int
    let name: String?
    let status: Status
    let image: String?
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
