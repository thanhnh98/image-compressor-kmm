//
//  UIImageExtension.swift
//  iosApp
//
//  Created by Thanh on 19/04/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Photos

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func saveImageToPhotosLibrary(
        onResultCallback: @escaping (ImageInfoModel?) -> Void
    ) {
        @State var imageInfoModel: ImageInfoModel?
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        if let lastAssetCollection = fetchResult.lastObject {
            let fetchResult = PHAsset.fetchAssets(in: lastAssetCollection, options: fetchOptions)
            if let asset = fetchResult.firstObject {
                self.getAssetURL(asset: asset) { url in
                    if url != nil {
                        let imageInfoModel = imageInfoFromURL(url: url!)
                        onResultCallback(imageInfoModel)
                    }
                }
            }
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("saved successful")
        }
    }
    
    func getAssetURL(asset: PHAsset, onValueReceived: @escaping (URL?) -> Void) {
        let options = PHContentEditingInputRequestOptions()
        options.canHandleAdjustmentData = {(data: PHAdjustmentData) -> Bool in
            return true
        }
        asset.requestContentEditingInput(with: options) { (contentEditingInput, info) in
            DispatchQueue.main.async {
                let url = contentEditingInput?.fullSizeImageURL
                onValueReceived(url)
            }
        }
    }
    
    func compressImage(quality: CGFloat = 0.5) -> UIImage? {
        var imageData =  Data(self.pngData()! )
        print("***** Uncompressed Size \(imageData.description) **** ")
        
        imageData = self.jpegData(compressionQuality: quality)!
        print("***** Compressed Size \(imageData.description) **** ")
        
        return UIImage(data: imageData)
        
    }
}

func uiImageFromPath(path: String) -> UIImage? {
    let url = URL.init(fileURLWithPath: path)

    let imageData:NSData = NSData(contentsOf: url)!

    return UIImage(data: imageData as Data)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func imageInfoFromURL(url: URL) -> ImageInfoModel {
    let uiImage = uiImageFromPath(path: url.path)
    let imageName = (url.path as NSString).lastPathComponent
    let imageSize = uiImage?.size ?? CGSize(width: 0, height: 0)
    var fileSize: Int = 0
    do {
        fileSize = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
    } catch {
        fileSize = 0
    }
    
   return  ImageInfoModel(name: imageName, width: imageSize.width, height: imageSize.height, sizeInKb: fileSize, path: url.path)
}
