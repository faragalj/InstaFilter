//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Joseph Faragalla on 2020-08-27.
//  Copyright © 2020 Joseph Farag Alla. All rights reserved.
//

import SwiftUI
//because it conforms UIViewControllerRepresentable, it can immediatly be placed in a swiftui view
struct ImagePicker: UIViewControllerRepresentable {
    
    //creating a delegate that will actually do something with the picture the user has chosen
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        //need to reference ImagePicker.image in our code. This is how we get it into this class
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        //controlling action for after user selects an image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presenationMode.wrappedValue.dismiss()
        }
        
        
    }
    
    
    @Environment(\.presentationMode) var presenationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    //this function is called when this view is presented
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        //setting the delegate
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
