//
//  ContentView.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

struct ContentView: View {
    @State var library = Library()
    var body: some View {
        NavigationView {
            List(library.sortedBooks) { book in
                BookRow(book: book, image: $library.uiImages[book])
            }
            .navigationBarTitle("My Library")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewedInAllColorSchemes
        }
    }
}



struct BookRow: View {
    let book: Book
    @Binding var image: UIImage?
    
    var body: some View {
        NavigationLink(
            destination: DetailView(book: book, image: $image),
            label: {
                HStack {
                    Book.Image(
                        uiImage: image,
                        title: book.title, size: 80,
                        cornerRadius: 12
                    )
                        .padding(.trailing, 3)
                    TitleAndAuthorStack(book: book, titleFont: .title3, authorFont: .title2)
                        .lineLimit(1)
                }
            })
    }
}


