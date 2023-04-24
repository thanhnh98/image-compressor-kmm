//
//  ResultCompressImagécreen.swift
//  iosApp
//
//  Created by Thanh on 23/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct ReviewCompressedImageScreen: View {
    
    @Binding var isRootActive: Bool
    var originImage: ImageInfoModel
    var compressedImage: ImageInfoModel
    
    var body: some View {
        VStack {
            ActionBar(
                title: "Thành công",
                textOption: "Chia sẻ",
                onBackPressed: {
                    isRootActive = false
                },
                onOptionTextPressed: {
                    
                },
                iconBack: "ic_close"
            )
            .frame(height: 48)
            
            Text("Chúc mừng!!\nGiảm dung lượng ảnh hoàn tất")
                .textStyleBold(
                    size: 18,
                    color: Colors.ColorPrimaryDark
                )
                .multilineTextAlignment(TextAlignment.center)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            
            HStack {
                Text("Yayyy! Đã giảm dung lượng \(Text("**\(originImage.sizeFormatted())**").foregroundColor(Colors.Red_0a)) chỉ còn \(Text("**\(compressedImage.sizeFormatted())**").foregroundColor(Colors.Green_3c))")
                    .textStyleNormal(
                        size: 16,
                        color: Colors.Gray_93
                    )
                    .multilineTextAlignment(TextAlignment.center)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                
            }
            
            CompareImages(
                originImage: originImage,
                compressedImage: compressedImage
            )
                .padding(
                    .trailing, 16
                )
                .padding(
                    .leading, 16
                )
                .padding(.top, 16)
                .frame(height: 160)
            
            
            Text("**Lưu trong: Photos**")
                .textStyleNormal(
                    size: 16,
                    color: Colors.Gray_93
                )
                .multilineTextAlignment(TextAlignment.center)
                .padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
            
            PrimaryButton(text: "View Result", isEnable: true, onPressed: {})
                .frame(height: 48)
            
            Text("Xoá ảnh")
                .textStyleNormal(
                    size: 16,
                    color: Colors.Red_0a
                )
                .multilineTextAlignment(TextAlignment.center)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
            
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct ReviewCompressedImageScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewCompressedImageScreen()
//    }
//}
