//
//  BookViews.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

extension Book {
    struct Image: View {
        let title: String
        var size: CGFloat?
        
        var body: some View {
            let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
            symbol
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .font(Font.title.weight(.light))
                .foregroundColor(.secondary)
        }
    }
}
struct Book_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TitleAndAuthorStack(book: .init(), titleFont: .title, authorFont: .title2)
            Book.Image(title: "")
                .padding(.bottom)
            Book.Image(title: "N")
            Book.Image(title: "O")
            Book.Image(title: "I")
            Book.Image(title: "C")
            Book.Image(title: "E")
            Book.Image(title: "")
                .padding(.top)
        }
    }
}

struct TitleAndAuthorStack: View {
    let book: Book
    let titleFont: Font
    let authorFont: Font
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(titleFont)
            Text(book.author)
                .font(authorFont)
                .foregroundColor(.secondary)
        }
    }
}

extension Image {
    init?(title: String) {
        guard
            let character = title.first,
            case let symbolNmae = "\(character.lowercased()).square",
                UIImage(systemName: symbolNmae) != nil
        else {
            return nil
        }
        self.init(systemName: symbolNmae)
    }
}
