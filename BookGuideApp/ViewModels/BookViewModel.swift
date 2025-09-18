//
//  BookViewModel.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 16.09.2025.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var categories = ["Roman","Fantastik","Kişisel Gelişim","Şiir","Bilim","Çocuk"]
    @Published var selectedCategory: String = "Roman"
    
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
