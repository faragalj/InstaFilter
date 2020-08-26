//
//  ContentView.swift
//  InstaFilter
//small useless Change
//  Created by Joseph Faragalla on 2020-08-23.
//  Copyright © 2020 Joseph Farag Alla. All rights reserved.
//

import SwiftUI
//will help eventually bring image to desired format
import CoreImage
//has the filters we are using
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("the new blur amount is \(blurAmount)")
        }
    }
    
    var body: some View {
        //blur will now observe blur amount and will notice any changes and act accordingly
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            Slider(value: blur, in: 0 ... 20)
        }
        
    }
}

struct UsingActionSheet: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
        .actionSheet(isPresented: $showingActionSheet) { () -> ActionSheet in
            ActionSheet(title: Text("Change background"), message: Text("Select a new background color"), buttons: [
                .default(Text("Red"), action: {
                    self.backgroundColor = .red
                }),
                .default(Text("Green"), action: {
                    self.backgroundColor = .green
                }),
                .cancel()
                
            
            ])
        }
    }
}

struct UsingCoreImage: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
            .resizable()
            .scaledToFit()
        }
    //have to attach this to the VStack and not the image. Because if there is no image it would never "appear" and the function would never run.
        .onAppear(perform: loadImage)
    }
    func loadImage() {
        //core Image only works with CIImage. so we have to convert our image into that. we cannot it convert to it directly from a swiftui Image.
        guard let inputImage = UIImage(named: "exampleBanana") else { return }
        let beginImage = CIImage(image: inputImage)
        
        //creating the context and filter
        let context = CIContext()
        let currentFilter = CIFilter.pixellate()
        
        currentFilter.inputImage = beginImage
        currentFilter.scale = 100
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}


class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingwithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }
}

struct WrappingUIKitViews: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select an image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            //passing it in to the @Biding property, when one chnages the other will too
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        //takes the image we recieived form image picker and converts it to a swiftUI Image we can use in our view
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        //saving the photo to the user library. Since we are not editing it at all right now, it will simply just duplicate the photo
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
