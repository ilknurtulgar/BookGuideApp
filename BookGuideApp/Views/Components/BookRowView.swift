//
//  BookRowView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 18.09.2025.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        HStack{
            if let urlString = book.volumeInfo.imageLinks?.thumbnail,
               let secureUrl = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")){
                AsyncImage(url: secureUrl){image in
                image
                        .resizable()
                        .scaledToFill()
                }placeholder: {
                    Color.gray
                }
                .frame(width: 50,height: 75)
              
            }
            else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50,height: 75)
                    
            }
            
            VStack(alignment: .leading,spacing: 4){
                Text(book.volumeInfo.title ?? "None")
                    .font(.headline)
                Text(book.volumeInfo.authors?.joined(separator: ", ") ?? "None")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical,4)
    }
}

#Preview {
    BookRowView(book: Book(id: "123", volumeInfo: VolumeInfo(title: "Martin eden", authors: ["John", "Green"], publisher: "asdf", imageLinks: ImageLinks(thumbnail: "www.google.com"), description: "lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, ")))
}
