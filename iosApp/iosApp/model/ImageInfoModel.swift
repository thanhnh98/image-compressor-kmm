//
//  ImageInfoModel.swift
//  iosApp
//
//  Created by Thanh on 17/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

class ImageInfoModel {
    var name: String
    var width: CGFloat
    var height: CGFloat
    var sizeInKb: Int
    var path: String?
    
    init(name: String, width: CGFloat, height: CGFloat, sizeInKb: Int, path: String?) {
        self.name = name
        self.width = width
        self.height = height
        self.sizeInKb = sizeInKb
        self.path = path
    }
    
    func sizeFormatted() -> String {
        return convertBytesToString(self.sizeInKb)
    }
}
