//
//  ImageInfoSection.swift
//  iosApp
//
//  Created by Thanh on 16/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

    struct ImageInfoSection: View {
    
    private(set) var onImagePickerRequest: () -> Void
    var uiImage: UIImage? = nil
    var imageInfoModel: ImageInfoModel? = nil
    
    var body: some View {
        GeometryReader { geo in
            let resultSize = (imageInfoModel?.sizeInKb ?? 0) * 20/100
            let compressedSize = (imageInfoModel?.sizeInKb ?? 0) * 80/100
            
            VStack {
                ZStack {
                    
                    if let uiImage = self.uiImage {
                        ImagePreview(uiImage: uiImage)
                            .padding(.all, 16)
                            .onTapGesture {
                                onImagePickerRequest()
                            }
                    }
                    else
                    {
                        EmptyMedia()
                            .padding(.all, 16)
                            .onTapGesture {
                                onImagePickerRequest()
                            }
                        
                    }
                    
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(
                            style: StrokeStyle(lineWidth: 2, dash: [4, 6, 4, 6])
                        )
                        .foregroundColor(Colors.ColorPrimaryDark)
                    
                        .frame(width: geo.size.width - 32,  height: geo.size.height/1.75 - 32)
                }
                .frame(width: geo.size.width, height: geo.size.height/1.75)
                
                if let imageInfoModel = self.imageInfoModel {
                    Text("Thay đổi")
                        .textStyleNormal(color: Colors.ColorPrimary)
                        .onTapGesture {
                            onImagePickerRequest()
                        }
                    
                    VStack {
                        Text("\(imageInfoModel.sizeFormatted())")
                            .textStyleBold(size: 24, color: Colors.ColorPrimaryDark)
                            .padding(.top, 12)
                        
                        HStack(alignment: VerticalAlignment.top) {
                            Text("Giảm đến: ")
                                .textStyleBold(color: Colors.ColorPrimaryDark)
                            
                            Text("**~\(convertBytesToString(_:resultSize))** (giảm \(convertBytesToString(_:compressedSize)))")
                                .textStyleNormal(color: Colors.Green_3c)
                        }
                        .padding(.top, 4)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .frame(width: geo.size.width, alignment: .leading)
                        
                        HStack(alignment: VerticalAlignment.top) {
                            Text("Tên file: ")
                                .textStyleBold(color: Colors.ColorPrimaryDark)
                            
                            Text(imageInfoModel.name)
                                .textStyleNormal(color: Colors.ColorPrimaryDark)
                        }
                        .padding(.top, 1)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .frame(width: geo.size.width, alignment: .leading)
                        
                        HStack(alignment: VerticalAlignment.top) {
                            Text("Độ phân giải: ")
                                .textStyleBold(color: Colors.ColorPrimaryDark)
                            
                            Text("\(Int(round(imageInfoModel.width)))x\(Int(round(imageInfoModel.height)))")
                                .textStyleNormal(color: Colors.ColorPrimaryDark)
                        }
                        .padding(.top, 1)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .frame(width: geo.size.width, alignment: .leading)
                    }
                    .frame(width: geo.size.width, height: .infinity)
                }

                }
                
        }
    }
}

struct ImageInfo_Previews: PreviewProvider {
    static var previews: some View {
        ImageInfoSection(
        onImagePickerRequest: {}
        )
    }
}
