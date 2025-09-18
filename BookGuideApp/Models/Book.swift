//
//  Book.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 16.09.2025.
//

import Foundation

struct BookResponse : Codable {
    let items: [Book]?
}

struct Book: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher: String?
    let imageLinks: ImageLinks?
    let description: String?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}
