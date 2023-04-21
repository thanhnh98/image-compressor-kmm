//
//  ItemFeature.swift
//  iosApp
//
//  Created by Thanh on 11/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct ItemFeature: View {
    var title: String
    var backgroundColor: Color
    var icResouces: String
    
    init(
        title: String,
        backgroundColor: Color,
        icResources: String
    ){
        self.title = title
        self.backgroundColor = backgroundColor
        self.icResouces = icResources
    }
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ZStack {
                    HStack (alignment: .top) {
                        Image("ic_decorate")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 68, height: 68, alignment: .topTrailing)
                            .padding(.leading, 24)
                            .padding(.bottom, 16)
                    }
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(
                            style: StrokeStyle(lineWidth: 2, dash: [4, 4, 4, 4])
                        )
                        .foregroundColor(Color.white)
                    
                        .frame(width: geo.size.width - 16, height: geo.size.height - 16)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
            }
            VStack (alignment: .leading){
                Spacer()
                Image(icResouces)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                Text(title)
                    .textStyleBold(
                        size: 16,
                        color: Color.white
                    )
                
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 24)
            .frame(width: geo.size.width - 16, height: geo.size.height - 16, alignment: .leading)
        }
        
    }
}

struct ContentView_ItemFeature: PreviewProvider {
    static var previews: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
            ItemFeature(
                title: "Compress",
                backgroundColor: Colors.Blue_6ff,
                icResources: "ic_image"
            )
            .frame(maxWidth: .infinity, minHeight: 140)
            .padding(.trailing, 8)

            ItemFeature(
                title: "Resize",
                backgroundColor: Colors.Orange_a5,
                icResources: "ic_scale"
            )
            .frame(maxWidth: .infinity, minHeight: 140)
            .padding(.leading, 8)

            ItemFeature(
                title: "Video",
                backgroundColor: Colors.Red_89,
                icResources: "ic_play_video"
            )
            .frame(maxWidth: .infinity, minHeight: 140)
            .padding(.trailing, 8)

            ItemFeature(
                title: "History",
                backgroundColor: Colors.Green_c5,
                icResources: "ic_history"
            )
            .frame(maxWidth: .infinity, minHeight: 140)
            .padding(.leading, 8)
        }
        .padding()

    }
}
