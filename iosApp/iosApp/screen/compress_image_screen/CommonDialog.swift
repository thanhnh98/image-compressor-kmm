//
//  CommonDialog.swift
//  iosApp
//
//  Created by Thanh on 20/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool // set this to show/hide the dialog
    let dialogContent: DialogContent
    @State private var opacity = 0.0
    
    init(isShowing: Binding<Bool>,
         @ViewBuilder dialogContent: () -> DialogContent) {
        _isShowing = isShowing
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        // wrap the view being modified in a ZStack and render dialog on top of it
        ZStack {
            content
            if isShowing {
                // the semi-transparent overlay
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.6))
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            opacity = 1.0
                        }
                    }
                    .onDisappear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            opacity = 0.0
                        }
                    }
                // the dialog content is in a ZStack to pad it from the edges
                // of the screen
                ZStack {
                    dialogContent
                        .edgesIgnoringSafeArea(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white))
                }.padding(40)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            opacity = 1.0
                        }
                    }
                    .onDisappear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            opacity = 0.0
                        }
                    }
            }
        }
    }
}

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        self.modifier(CustomDialog(isShowing: isShowing, dialogContent: dialogContent))
    }
}
