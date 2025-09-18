//
//  BookViewModel.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 16.09.2025.
//

import Foundation


struct Category {
    let title: String
    let query: String
    
    static let all: [Category] = [
        Category(title: "Recommended", query: "novel"),
        Category(title: "Fantastic", query: "fantasy"),
        Category(title: "Self-Help", query: "self-help"),
        Category(title: "Poem", query: "poetry"),
        Category(title: "Science", query: "science"),
        Category(title: "Child", query: "children")]
}

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var categories = Category.all
    @Published var selectedCategory = Category.all[0]
    @Published var searchText: String = ""
    @Published var isGridView = false

    
    func fetchBooks(query: String) async {
        isLoading = true
        defer {isLoading = false}
        
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)&langRestrict=tr"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from:   url)
            let decodedResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            self.books = decodedResponse.items ?? []
        } catch  {
            errorMessage = "Data couldn't be loaded: \(error.localizedDescription)"
        }
    }
}
