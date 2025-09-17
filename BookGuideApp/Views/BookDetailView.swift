//
//  BookDetailView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 16.09.2025.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BookDetailView(book: Book(id: "123", volumeInfo: VolumeInfo(title: "Martin eden", authors: ["John", "Green"], publisher: "asdf", imageLinks: ImageLinks(thumbnail: "www.google.com"))))
}
