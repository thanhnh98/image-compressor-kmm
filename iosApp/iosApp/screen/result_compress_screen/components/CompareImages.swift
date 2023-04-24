//
//  CompareImages.swift
//  iosApp
//
//  Created by Thanh on 23/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct CompareImages: View {
    var originImage: ImageInfoModel?
    var compressedImage: ImageInfoModel?
    
    var body: some View {
        GeometryReader { geo in
            HStack (alignment: .center){
                VStack {
                    Image(uiImage: uiImageFromPath(path: compressedImage?.path ?? "")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/2 - 24, height: 160, alignment: .center)
                        .background(Colors.Black_1c)
                    
                    Text("\(Text("**\(originImage?.sizeFormatted() ?? "")**").foregroundColor(Colors.Red_0a)) | \(Int(round(originImage?.width ?? 0.0)))x\(Int(round(originImage?.height ?? 0.0)))")
                        .textStyleNormal(
                            size: 12,
                            color: Colors.Gray_93
                        )
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                Image("ic_convert")
                    .frame(width: 16, height: 16)
                    .padding(.leading, 6)
                    .padding(.trailing, 6)
                
                VStack {
                    Image(uiImage: uiImageFromPath(path: compressedImage?.path ?? "")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/2 - 24, height: 160, alignment: .center)
                        .background(Colors.Black_1c)
                    
                    Text("\(Text("**\(compressedImage?.sizeFormatted() ?? "")**").foregroundColor(Colors.Green_3c)) | \(Int(round(compressedImage?.width ?? 0.0)))x\(Int(round(compressedImage?.height ?? 0.0)))")
                        .textStyleNormal(
                            size: 12,
                            color: Colors.Gray_93
                        )
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .frame(width: geo.size.width, height: 160)
        }
    }
}

//struct CompareImages_Previews: PreviewProvider {
//    static var previews: some View {
//        CompareImages()
//    }
//}
