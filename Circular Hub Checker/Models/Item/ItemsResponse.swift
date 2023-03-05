//
//  ItemsResponse.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 20/1/23.
//

import Foundation

struct ItemsResponse: Codable {
    let content: [Item]
    let pageable: Pageable
    let totalElements, totalPages, size, number, numberOfElements: Int
    let first, last, empty: Bool
    let sort: Sort
}

// MARK: - Pageable
struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

// MARK: - Sort
struct Sort: Codable {
    let empty, sorted, unsorted: Bool
}
