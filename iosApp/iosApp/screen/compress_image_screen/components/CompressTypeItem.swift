//
//  CompressTypeItem.swift
//  iosApp
//
//  Created by Thanh on 19/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct CompressTypeItem: View {
    @State private(set) var isOn: Bool
    @State private(set) var percentValue: Float
    
    private(set) var onAutoCompressValueChanged: (Bool) -> Void
    private(set) var onPercentValueChanged: (Float) -> Void
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text("Kiểu nén")
                    .textStyleNormal(
                        color: Colors.Gray_93
                    )
                
                VStack {
                    Toggle(isOn: $isOn){
                        Text("Nén tự động")
                            .textStyleBold(
                                color: Colors.Black_1c
                            )
                    }
                    .onChange(of: isOn, perform: { newValue in
                        onAutoCompressValueChanged(newValue)
                    })
                    .toggleStyle(
                        SwitchToggleStyle(tint: Colors.ColorPrimary)
                    )
                    
                    if !isOn {
                        HStack {
                            Text("Chất lượng ảnh")
                                .textStyleBold(
                                    color: Colors.Black_1c
                                )
                            Spacer()
                            Text("\(Int(round(percentValue)))%")
                                .textStyleBold(
                                    color: Colors.ColorPrimaryDark
                                )
                        }
                        .padding(.top, 16)
                        
                        Slider.init(value: $percentValue, in: 10...80, step: 1, onEditingChanged: {currentValue in
                            onPercentValueChanged(percentValue)
                        })
                        .accentColor(Colors.ColorPrimary)
                        .onChange(of: EquatableBinding(percentValue)) { newValue in
                            print("new value: \(newValue.wrappedValue)")
                        }
                        
                        Text("*Chất lượng ảnh càng cao sẽ chiếm nhiều dung lượng của thiết bị")
                            .textStyleNormal(
                            size: 12,
                            color: Colors.Red_0a
                            )
                    }
                }
                .padding(
                    EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16)
                )
                .background(
                    Color.white
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 1)
            }
            .padding(.all, 16)
        }
    }
}


struct EquatableBinding<T>: Equatable where T: Equatable {
    let wrappedValue: T
    static func == (lhs: EquatableBinding<T>, rhs: EquatableBinding<T>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .green : .gray)
        }
    }
}

//struct CompressType_Previews: PreviewProvider {
//    static var previews: some View {
//        CompressTypeItem()
//    }
//}
