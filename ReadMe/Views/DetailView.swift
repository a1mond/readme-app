//
//  DetailView.swift
//  ReadMe
//
//  Created by Владислав Котик on 09/09/2021.
//
import class PhotosUI.PHPickerViewController
import SwiftUI

struct DetailView: View {
    let book: Book
    @Binding var image: UIImage?
    @State var showingImagePicker = false
    @State var showingDeleteMessage = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndAuthorStack(book: book, titleFont: .title, authorFont: .title2)
            VStack {
                Book.Image(
                    uiImage: image,
                    title: book.title,
                    cornerRadius: 16.0
                )
                .scaledToFit()
                HStack {
                    if (image != nil) {
                        Spacer()
                        Button("Delete Image") {
                            showingDeleteMessage = true
                        }
                    }
                    Spacer()
                    Button("Update Image") {
                        showingImagePicker = true
                    }.padding()
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingImagePicker) {
            PHPickerViewController.View(image: $image)
        }
        .alert(isPresented: $showingDeleteMessage) {
            .init(
                title: .init("Delete image for \(book.title)?"),
                primaryButton: Alert.Button.destructive(.init("Delete")) {
                    image = nil
                },
                secondaryButton: .cancel())
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(book: .init(), image: .constant(nil))
            .previewedInAllColorSchemes
    }
}
