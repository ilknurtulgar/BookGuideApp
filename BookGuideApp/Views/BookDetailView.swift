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
        ScrollView{
            VStack(alignment: .leading,spacing: 16){
                if let urlString = book.volumeInfo.imageLinks?.thumbnail,
                   let secureUrl = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")){
                    AsyncImage(url: secureUrl){image in
                    image
                            .resizable()
                            .scaledToFill()
                      
                    }placeholder: {
                        Color.gray.frame(height: 100)
                    }
                }else{
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50,height: 75)
                }
                
                    Text(book.volumeInfo.title ?? "No Title")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom,4)
                
                    Text(book.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author")
                        .font(.headline)
                        .foregroundColor(.primary)
                
                if let published = book.volumeInfo.publisher{
                    Text(published)
                        .font(.callout)
                        .foregroundColor(.primary)
                        
                }
                Divider()
                
                if let description = book.volumeInfo.description{
                    Text(description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                }
            }
            .padding()
        }
        
        .navigationTitle("Book Detail")
    }
}

#Preview {
    BookDetailView(book: Book(id: "123", volumeInfo: VolumeInfo(title: "Martin eden", authors: ["John", "Green"], publisher: "asdf", imageLinks: ImageLinks(thumbnail: "www.google.com"), description: "lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum,")))
}
