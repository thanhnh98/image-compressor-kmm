//
//  EmptyMedia.swift
//  iosApp
//
//  Created by Thanh on 16/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct EmptyMedia: View {
    var body: some View {
        GeometryReader {geo in
            ZStack {
                VStack {
                    Image("ic_plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Colors.ColorPrimaryDark)
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    
                    Text("Pick any image")
                        .textStyleBold(
                            color: Colors.ColorPrimaryDark
                        )
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .background(Colors.Gray_ed)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct EmptyMedia_Previews: PreviewProvider {
    static var previews: some View{
        EmptyMedia()
    }
}
