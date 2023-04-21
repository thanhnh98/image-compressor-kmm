//
//  ViewExtension.swift
//  iosApp
//
//  Created by Thanh on 11/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

extension Text {
    func textStyleNormal(
        size: CGFloat = 16,
        color: Color = Colors.Black_1c
    ) -> some View {
        self.foregroundColor(color)
            .font(.system(size: size))
        }
    func textStyleBold(
        size: CGFloat = 16,
        color: Color = Colors.Black_1c
    ) -> some View {
        self.foregroundColor(color)
            .font(.system(size: size, weight: .heavy, design: .default))
        }
}

extension View {
    func bold() -> some View {
        font(Font.body.bold())
    }
}

func convertBytesToString(_ bytes: Int) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useKB, .useMB]
    formatter.countStyle = .file
    return formatter.string(fromByteCount: Int64(bytes))
}
