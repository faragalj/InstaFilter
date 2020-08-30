//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Joseph Faragalla on 2020-08-29.
//  Copyright © 2020 Joseph Farag Alla. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    
    var sucessHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    
    func writeToPhotosAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            errorHandler?(error)
        }
        else {
            sucessHandler?()
        }
    }
}
