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
        @Published var openCompareScreen = false
        @Published var isSuccessful = false
        @Published var compressedResult: ResultCompressModel? = nil
        
        private var compressPercent: Float = 0.0
        
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
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                
                if self.isAutoCompress {
                    self.compressPercent = 50.0
                }
                else {
                    self.compressPercent = self.imageQuality
                }
                
                if imageInfo.path != nil {
                    print("compressing: \(imageInfo.name) - auto: \(self.isAutoCompress) - percent:\(self.compressPercent)")
                    let uiImage = uiImageFromPath(path: imageInfo.path!)
                    uiImage?.compressImage(
                        quality: CGFloat(self.compressPercent)
                    )?.saveImageToPhotosLibrary(onResultCallback: { imageCompressed in
                        
                        DispatchQueue.main.async {
                            self.isSuccessful = true
                        }
                        
                        if let result = imageCompressed {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.compressedResult = ResultCompressModel(originImage: imageInfo, compressedImage: result)
                                self.openCompareScreen = true
                                self.showProcessDialog = false
                            }
                        }
                    })
                }
            }
            
        }
    }
}

struct ResultCompressModel {
    var originImage: ImageInfoModel
    var compressedImage: ImageInfoModel
}
