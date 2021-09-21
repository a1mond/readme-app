//
//  BookViews.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

extension Book {
    struct Image: View {
        let uiImage: UIImage?
        let title: String
        var size: CGFloat?
        let cornerRadius: CGFloat
        
        var body: some View {
            if let img = uiImage.map(SwiftUI.Image.init) {
                img
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(cornerRadius)
            } else {
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
}
struct Book_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                BookmarkButton(book: .init())
                BookmarkButton(book: .init(readMe: false))
                TitleAndAuthorStack(book: .init(), titleFont: .title, authorFont: .title2)
            }
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
        .previewedInAllColorSchemes
    }
    
}

struct BookmarkButton: View {
    var book: Book
    
    var body: some View {
        let bookmark = "bookmark"
        
        Button {
            
        } label: {
            Image(systemName: book.readMe ? "\(bookmark).fill" : bookmark)
                .font(.system(size: 48, weight: .light))
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

extension Book.Image {
    init(title: String) {
        self.init(
            uiImage: nil,
            title: title,
            cornerRadius: .init()
        )
    }
}

extension View {
    var previewedInAllColorSchemes: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme)
    }
}
