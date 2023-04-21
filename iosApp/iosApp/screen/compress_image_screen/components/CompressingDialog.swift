//
//  CompressingDialog.swift
//  iosApp
//
//  Created by Thanh on 21/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI


struct CompressingDialog: View {
   @State var isSuccessful = false
    var body: some View {
        VStack {
          Text("In Compressing")
                .textStyleBold(
                    color: Colors.ColorPrimaryDark
                )
            
            if isSuccessful {
                LottieView(lottieFile: "lottie_success")
                    .loop(loop: true)
                    .frame(width: 150, height: 150)
            }
            else {
                LottieView(lottieFile: "lottie_image_swap")
                    .loop(loop: false)
                    .frame(width: 150, height: 150)
            }
            
            Text("Waiting for a second...")
                .textStyleNormal(
                    color: Colors.ColorPrimaryDark
                )
        }
        .padding(
            .all, 48
        )
    }
}

struct CompressDialog_Previews: PreviewProvider {
    static var previews: some View {
        CompressingDialog()
    }
}
