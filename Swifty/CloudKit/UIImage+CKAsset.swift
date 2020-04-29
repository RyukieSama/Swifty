//
//  UIImage+CKAsset.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/11/15.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import Foundation
import CloudKit

public extension UIImage {
    var asset: CKAsset? {
        get {
            let data = self.pngData()
            if let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString + ".dat") {
                do {
                    try data?.write(to: url)
                } catch let e as NSError {
//                    print("Error! \(e)")
                }
                return CKAsset(fileURL: url)
            }
            return nil
        }
    }
    
    static func image(fromRecord record: CKRecord,forAssetKey key: String) -> UIImage? {
        if let asset = record[key] as? CKAsset, let url = asset.fileURL {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                return image
            }
            catch {
                
            }
        }
        return nil
    }
}
