//
//  PrimaryButton.swift
//  iosApp
//
//  Created by Thanh on 16/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    
    private(set) var text: String
    private(set) var isEnable: Bool
    private(set) var onPressed: () -> Void

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    Text(text)
                        .textStyleBold(
                            color: Color.white
                        )
                }
                .frame(width: geo.size.width - 32, height: 48, alignment: .center)
                .background(
                    backgroundColor(isEnable: self.isEnable)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .onTapGesture {
                    if isEnable {
                        onPressed()
                    }
                }
            }
            .padding(
                .top, 8
            )
            .padding(
                .bottom, 8
            )
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .background(Color.white)
            .frame(width: geo.size.width, height: 48, alignment: .center)
        }
    }
}

extension PrimaryButton {
    func backgroundColor(isEnable: Bool) -> Color {
            if isEnable {
                return Colors.ColorPrimary
                
            } else {
                return Colors.Gray_ed
            }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(
            text: "Primary Button",
            isEnable: true,
            onPressed: {
                
            }
        )
    }
}
