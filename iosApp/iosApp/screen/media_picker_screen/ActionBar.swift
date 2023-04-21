//
//  ActionBar.swift
//  iosApp
//
//  Created by Thanh on 16/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct ActionBar: View {
    private(set) var title: String
    private(set) var textOption: String = ""
    private(set) var onBackPressed: () -> Void
    private(set) var onOptionTextPressed: () -> Void = {}
    
    var body: some View {
        GeometryReader { geo in
            HStack (alignment: .center) {
                Image("ic_arrow_back")
                    .resizable()
                    .scaledToFit()
                    .font(.headline)
                    .frame(width: 16, height: 16)
                    .onTapGesture {
                        onBackPressed()
                    }
                
                Text(title)
                    .textStyleBold(
                        color: Colors.Black_1c
                    )
                
                Spacer()
            
                Text(textOption)
                    .textStyleNormal(
                        color: Colors.Red_0a
                    )
                    .frame(alignment: .trailing)
                    .onTapGesture {
                        onOptionTextPressed()
                    }
                
                
            }
            .padding()
            .foregroundColor(.primary)
        }
        .frame(height: 48)
        
    }
}

struct ActionBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            ActionBar(
                title: "Pick an image",
                textOption: "Compress",
                onBackPressed: {}
            )
        }
    }
}
