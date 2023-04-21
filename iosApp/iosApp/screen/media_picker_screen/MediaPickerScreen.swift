//
//  MediaPickerScreen.swift
//  iosApp
//
//  Created by Thanh on 16/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Photos

struct MediaPickerScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isShowPicker: Bool = false
    @State var uiImage: UIImage? = nil
    @State var imageInfoModel: ImageInfoModel? = nil
    @State var showCompressImageScreen: Bool = false
    
    var body: some View {
        VStack {
            if let imageInfo = imageInfoModel {
                NavigationLink(
                    destination: CompressImageScreen(sourceImageModel: imageInfo), isActive: $showCompressImageScreen){
                        EmptyView()
                    }
                    .hidden()
            }
            
            ActionBar(
                title: "Pick any image",
                onBackPressed: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            
            ImageInfoSection(
                onImagePickerRequest: {
                    isShowPicker = true
                },
                uiImage: self.uiImage,
                imageInfoModel: self.imageInfoModel
            )
            .sheet(isPresented: self.$isShowPicker){
                ImagePicker(uiImage: self.$uiImage, imageInfoModel: self.$imageInfoModel)
            }
            
            PrimaryButton(
                text: "Continue",
                isEnable: imageInfoModel != nil,
                onPressed: {
                    self.showCompressImageScreen = true
                }
            )
            .frame(height: 48)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var uiImage: UIImage?
    @Binding var imageInfoModel: ImageInfoModel?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var imageInfoModel: ImageInfoModel?
        @Binding var uiImage: UIImage?
        
        private var imageSelected: UIImage? = nil
        
        init(presentationMode: Binding<PresentationMode>, uiImage: Binding<UIImage?>, imageInfoModel: Binding<ImageInfoModel?>) {
            _presentationMode = presentationMode
            _uiImage = uiImage
            _imageInfoModel = imageInfoModel
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageSelected = image
            } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageSelected = image
            }
            
            if let localImage = imageSelected {
                uiImage = localImage
            }
            
            let url = info[UIImagePickerController.InfoKey.imageURL] as? URL ?? nil
            let imageName = (url?.path as? NSString)?.lastPathComponent ?? "N/A"
            let imageSize = uiImage?.size ?? CGSize(width: 0, height: 0)
            var fileSize: Int = 0
            do {
                fileSize = try url?.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
            } catch {
                fileSize = 0
            }
            
            let selectedResult: ImageInfoModel = ImageInfoModel(
                name: imageName,
                width: imageSize.width,
                height: imageSize.height,
                sizeInKb: fileSize,
                path: url?.path
            )
            
            imageInfoModel = selectedResult
            presentationMode.dismiss()
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(presentationMode: presentationMode, uiImage: $uiImage, imageInfoModel:$imageInfoModel)
        return coordinator
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}
