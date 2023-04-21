//
//  CompressImageViewModel.swift
//  iosApp
//
//  Created by Thanh on 20/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension CompressImageScreen {
    class CompressImageViewModel: ObservableObject {
        @Published private(set) var imageQuality: Float = 50.0
        @Published private(set) var isAutoCompress = true
        @Published var showProcessDialog = false
        @Published var isSuccessful = false
        
        func updateAutoCompress(value: Bool){
            self.isAutoCompress = value
        }
        
        func updateValueQuality(value: Float) {
            self.imageQuality = value
        }
        
        func compressImage(imageInfo: ImageInfoModel) {
            DispatchQueue.main.async {
                self.showProcessDialog = true
            }
            DispatchQueue.main.async {
                self.isSuccessful = true
            }
//            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
//                if imageInfo.path != nil {
//                    let uiImage = uiImageFromPath(path: imageInfo.path!)
//                    uiImage?.compressImage()?.saveImageToPhotosLibrary(onResultCallback: { imageCompressed in
//                        self.isSuccessful = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                            self.showProcessDialog = false
//                        }
//                    })
//                }
//            }
            
        }
    }
}
