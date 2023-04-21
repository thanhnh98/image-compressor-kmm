//
//  ShortPreviewImage.swift
//  iosApp
//
//  Created by Thanh on 19/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct ShortPreviewItem: View {
    private(set) var imageInfoModel: ImageInfoModel
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Image(uiImage: uiImageFromPath(path: imageInfoModel.path ?? "")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 96, height: 96)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .background(Colors.Gray_db)
                
                VStack(alignment: .leading) {
                    
                    Text("\(convertBytesToString(_:imageInfoModel.sizeInKb))")
                        .textStyleBold(color: Colors.ColorPrimaryDark)
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    Text("\(Int(round(imageInfoModel.width)))x\(Int(round(imageInfoModel.height)))")
                        .textStyleNormal()
                    
                    Spacer()
                    
                    Text(imageInfoModel.name)
                        .textStyleNormal(color: Colors.Gray_93)
                    
                    Spacer()
                    Spacer()
                }
                .frame(height: 96)
                .padding(.leading, 4)
            }
            .padding(.all, 12)
            .background(Colors.Purple8f1)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 2)
        }
        .padding(
            .all, 16
        )
        .frame(height: 150)
    }
}

struct ShortPreviewItem_Previews: PreviewProvider {
    static var previews: some View {
        ShortPreviewItem(
            imageInfoModel: .init(
                name: "A25DC0E5-E03C-40A7-91C3-F9DB88ED3E32.jpeg",
                width: 1080,
                height: 2048,
                sizeInKb: 1333040,
                path: "/Users/thanh/Library/Developer/CoreSimulator/Devices/3E204B4E-3696-4ED7-B1F6-E6B9B4FE7644/data/Containers/Data/Application/CC7D99AE-5072-49B6-897F-D52BD7860C1C/tmp/9635F189-C45B-4442-847D-4304F0DCEEA6.jpeg"
            )
        )
    }
}
