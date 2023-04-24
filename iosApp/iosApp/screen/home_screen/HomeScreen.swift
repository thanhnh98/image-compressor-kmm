//
//  HomeScreen.swift
//  iosApp
//
//  Created by Thanh on 11/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//
import SwiftUI
import shared
import Foundation

struct HomeScreen: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var isActive = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            NavigationLink(destination: MediaPickerScreen(isRootActive: $isActive), isActive: $isActive) {
                EmptyView()
            }
            .isDetailLink(false)
            .navigationBarBackButtonHidden(true)
            .hidden()
            
            HStack(alignment: .top) {

                ZStack(alignment: .topLeading) {

                    Image("img_header_background")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 150)

                    VStack (alignment: .leading) {
                        Text("Image Compressor")
                            .textStyleBold(
                                size: 24,
                                color: Colors.ColorPrimaryDark
                            )
                            .padding(.leading, 32)
                            .padding(.top, 32)

                        Text("Nén ảnh, video chất lượng cao")
                            .textStyleBold(
                                size: 16,
                                color: Colors.ColorPrimaryDark
                            )
                            .padding(.leading, 32)
                            .padding(.top, 1)
                        Spacer()
                    }
                }

                Spacer()
                Image("ic_menu")
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 32)
                    .padding(.top, 16)

            }
            .frame(height: 150)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                ItemFeature(
                    title: "Compress",
                    backgroundColor: Colors.Blue_6ff,
                    icResources: "ic_image"
                )
                .frame(maxWidth: .infinity, minHeight: 140)
                .padding(.trailing, 8)
                .onTapGesture {
                    isActive = true
    //                NavigationLink(destination: DetailView(item: "Item 1"))
                }

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

            Spacer()

        }
        .background(Color.white)
    }
}

struct DetailView: View {
    var item: String
    
    var body: some View {
        Text("Details for \(item)")
            .navigationTitle(item)
    }
}
