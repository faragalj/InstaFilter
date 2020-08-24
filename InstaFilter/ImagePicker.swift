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
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
