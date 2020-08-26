//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Joseph Faragalla on 2020-08-24.
//  Copyright © 2020 Joseph Farag Alla. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    //handles what happens after an image has been picked
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        //called when the image has been picked:
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //save that to the @Binding variable, which will reflec
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    //going to use @Binding so whatever the user chooses here will sync with WrappingUIkitViews().
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    
    //we do not have to call this ourselves. Swiftui calls it automaticaly when we create an ImagePicker
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        //set the coordinator as the delegate. if any action happens with the UIImagePickerController, tell the coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
