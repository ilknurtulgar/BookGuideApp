//
//  BookGridItemView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 18.09.2025.
//

import SwiftUI

struct BookGridItemView: View {
    var book: Book
    var body: some View {
        VStack{
            if let urlString = book.volumeInfo.imageLinks?.thumbnail,
               let secureUrl = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")){
                AsyncImage(url: secureUrl){image in
                image
                        .resizable()
                        .scaledToFill()
                      
                } placeholder: {
                    Color.gray
                }
                .frame(height: 150)
                .padding()
            }
            Text(book.volumeInfo.title ?? "No Title")
                .font(.headline)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding()
        }
        .padding()
        .background(Color.white)
        
    }
}

#Preview {
    BookGridItemView(book: Book(id: "123", volumeInfo: VolumeInfo(title: "Martin eden", authors: ["John", "Green"], publisher: "asdf", imageLinks: ImageLinks(thumbnail: "www.google.com"), description: "lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, ")))
}
