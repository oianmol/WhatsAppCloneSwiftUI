//
//  SUImagePickerView.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 06/12/20.
//
import SwiftUI
import UIKit

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var isPresented: Bool
    var callback: (UIImage) -> Void

    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(callback: callback, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isPresented: Bool
    var callback: (UIImage)-> Void

    init(callback: @escaping (UIImage)-> Void, isPresented: Binding<Bool>) {
        self.callback = callback
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let capturedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            callback(capturedImg)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
