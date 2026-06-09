import SwiftUI
import UIKit

// Camera view that allows the user to take or select a photo.
struct CameraView: UIViewControllerRepresentable {
    
    // Sends the selected photo back to the detail view.
    var onPhotoTaken: (UIImage) -> Void
    
    // Creates the coordinator that handles picker actions.
    func makeCoordinator() -> Coordinator {
        Coordinator(onPhotoTaken: onPhotoTaken)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        // Uses the camera if available, otherwise uses the photo library for the simulator.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update is needed for this picker.
    }
    
    // Coordinator works as the delegate for the image picker.
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var onPhotoTaken: (UIImage) -> Void
        
        init(onPhotoTaken: @escaping (UIImage) -> Void) {
            self.onPhotoTaken = onPhotoTaken
        }
        
        // Runs when the user takes or selects a photo.
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                onPhotoTaken(image)
            }
            picker.dismiss(animated: true)
        }
        
        // Runs when the user cancels the picker.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
