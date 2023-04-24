//
//  CompressImageScreen.swift
//  iosApp
//
//  Created by Thanh on 19/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Photos

struct CompressImageScreen: View {
    
    @Binding var isRootActive: Bool
    private (set) var sourceImageModel: ImageInfoModel
    @ObservedObject private var viewModel: CompressImageViewModel = CompressImageViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showPopup = false
    
    var body: some View {
        VStack {
            if let originImage = viewModel.compressedResult?.originImage, let compressedImage = viewModel.compressedResult?.compressedImage {
                NavigationLink(destination: ReviewCompressedImageScreen(
                    isRootActive: $isRootActive,
                    originImage: originImage,
                    compressedImage: compressedImage
                ), isActive: $viewModel.openCompareScreen
                ) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
                .hidden()
            }
            
            ActionBar(
                title: "Nén ảnh",
                textOption: "Compress",
                onBackPressed: {
                    presentationMode.wrappedValue.dismiss()
                },
                onOptionTextPressed: {
                    PHPhotoLibrary.requestAuthorization { status in
                        switch status {
                        case .authorized:
                            self.viewModel.compressImage(imageInfo: sourceImageModel)
                            return
                        case .denied, .restricted:
                            print("permisison denied")
                            return
                        case .notDetermined:
                            print("permisison not determined")
                            return
                            // User has not yet been asked for permission, request access again
                        case .limited:
                            print("permisison is limited")
                            return

                        @unknown default:
                            print("permisison got error")
                            fatalError()
                        }
                    }
                }
                
            )
            
            ShortPreviewItem(imageInfoModel: sourceImageModel)
            
            CompressTypeItem(
                isOn: viewModel.isAutoCompress,
                percentValue: viewModel.imageQuality,
                onAutoCompressValueChanged: { isEnable in
                    self.viewModel.updateAutoCompress(value: isEnable)
                },
                onPercentValueChanged: { value in
                    self.viewModel.updateValueQuality(value: value)
                }
            )
                .padding(.top, 16)
        }
        .navigationBarBackButtonHidden(true)
        .customDialog(isShowing: $viewModel.showProcessDialog) { // HERE
            CompressingDialog(
                isSuccessful: viewModel.isSuccessful
            )
        }
    }
}

//struct CompressImageScreen_Pewviews: PreviewProvider {
//    static var previews: some View {
//        CompressImageScreen(
//            sourceImageModel: .init(
//                name: "A25DC0E5-E03C-40A7-91C3-F9DB88ED3E32.jpeg",
//                width: 1080,
//                height: 2048,
//                sizeInKb: 1333040,
//                path: "/Users/thanh/Library/Developer/CoreSimulator/Devices/3E204B4E-3696-4ED7-B1F6-E6B9B4FE7644/data/Containers/Data/Application/34D92A86-A6AF-4D64-8D15-32A5B7FC00A5/tmp/5756557D-DFFD-447B-BB88-FF7FDDDF4DEC.jpeg"
//            )
//        )
//    }
//}
