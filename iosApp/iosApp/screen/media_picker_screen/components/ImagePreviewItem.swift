//
//  ImagePreviewItem.swift
//  iosApp
//
//  Created by Thanh on 16/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePreview: View {
    var uiImage: UIImage
    
    var body: some View {
        GeometryReader {geo in
            ZStack {
                Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            }
            .background(Colors.Black_1c)
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .background(Colors.Black_1c)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
