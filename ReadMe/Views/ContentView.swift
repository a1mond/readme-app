//
//  ContentView.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var library: Library
    @State var newBookSheet = false
    var body: some View {
        NavigationView {
            List {
                Button {
                    newBookSheet = true
                } label: {
                    Spacer()
                    VStack(spacing: 6.0) {
                        Image(systemName: "book.circle")
                            .font(.system(size: 60))
                        Text("Add new book")
                            .font(.title2)
                    }
                    Spacer()
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.vertical, 8)
                .sheet(isPresented: $newBookSheet, content: {
                    NewBookView(book: .init(title: "", author: ""), image: nil)
                })
                
                switch library.sortStyle {
                case .title, .author:
                    BookRows(data: library.sortedBooks, section: nil)
                case .manual:
                    ForEach(Section.allCases, id: \.self) {
                        SectionView(section: $0)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Sort") {
                        Picker("Sort Style", selection: $library.sortStyle) {
                            ForEach(SortStyle.allCases, id: \.self) { sortStyle in
                                Text("\(sortStyle)".capitalized)
                            }
                        }
                    }
                }
                ToolbarItem(content: EditButton.init)
            }
            .navigationBarTitle("My Library")
        }
    }
}

private struct BookRows: DynamicViewContent {
    let data: [Book]
    let section: Section?
    
    @EnvironmentObject var library: Library
    
    var body: some View {
        ForEach(data) {
            BookRow(book: $0)
        }
        .onDelete { indexSet in
            library.deleteBooks(atOffsets: indexSet, section: section)
        }
        .padding(.vertical, 5)
    }
}

private struct SectionView: View {
    let section: Section
    @EnvironmentObject var library: Library
    var title: String {
        switch section {
        case .readMe:
            return "IN PROGRESS!"
        case .finished:
            return "FINISHED!"
        }
    }
    
    var body: some View {
        if let books = library.manuallySortedBooks[section] {
            SwiftUI.Section(
                header: ZStack {
                    Image("BookTexture")
                        .resizable()
                        .scaledToFit()
                    Text(title)
                        .font(.custom("American Typewriter", size: 24))
                }
                .listRowInsets(.init())
            ) {
                BookRows(data: books, section: section)
                    .onMove { indices, newOffset in
                        library.moveBooks(oldOffsets: indices, newOffset: newOffset, section: section)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewedInAllColorSchemes
                .environmentObject(Library())
        }
    }
}



private struct BookRow: View {
    @ObservedObject var book: Book
    @EnvironmentObject var library: Library
    
    var body: some View {
        NavigationLink(
            destination: DetailView(book: book),
            label: {
                HStack {
                    Book.Image(
                        uiImage: library.uiImages[book],
                        title: book.title, size: 75,
                        cornerRadius: 12
                    )
                    .padding(.trailing, 3)
                    VStack(alignment: .leading) {
                        TitleAndAuthorStack(book: book, titleFont: .title3, authorFont: .title3)
                            .lineLimit(1)
                        if !book.microReview.isEmpty {
                            Spacer()
                            Text(book.microReview)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                    BookmarkButton(book: book)
                        .buttonStyle(BorderlessButtonStyle())
                }
            })
    }
}


