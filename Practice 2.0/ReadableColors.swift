//
//  ReadableColors.swift
//  Practice 2.0
//
//  Created by cdu on 2016-07-19.
//  Copyright © 2016 Michael Dziuba. All rights reserved.
//

import UIKit

class ReadableColors: NSObject, NSCoding {

    // MARK: Properties
    
    var infoColorCode: Int
    var textColorCode: Int
    var sortCode: Int
    var contrastCode: Int
    var minContrastRatioNumber: Float
    var textR: Float
    var textG: Float
    var textB: Float
    var seekBarPosition: Float
    var currentProgress: Int
    var progress: Int

    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("readableColors")
    
    // MARK: Types
    
    struct PropertyKey {
        static let infoColorCodeKey = "infoColorCode"
        static let textColorCodeKey = "textColorCode"
        static let sortCodeKey = "sortCode"
        static let contrastCodeKey = "contrastCode"
        static let minContrastRatioNumberKey = "minContrastRatio"
        static let textRKey = "textR"
        static let textGKey = "textG"
        static let textBKey = "textB"
        static let seekBarPositionKey = "seekBarPosition"
        static let currentProgressKey = "currentProgress"
        static let progressKey = "progress"
    }
    
    // MARK: Initialization
    
    init?(infoColorCode: Int, textColorCode: Int, contrastCode: Int, sortCode: Int, minContrastRatioNumber: Float,
          textR: Float, textG: Float, textB: Float, seekBarPosition: Float, currentProgress: Int, progress: Int) {
        // Initialize stored properties.
        self.infoColorCode = infoColorCode
        self.textColorCode = textColorCode
        self.contrastCode = contrastCode
        self.sortCode = sortCode
        self.minContrastRatioNumber = minContrastRatioNumber
        self.textR = textR
        self.textG = textG
        self.textB = textB
        self.seekBarPosition = seekBarPosition
        self.currentProgress = currentProgress
        self.progress = progress
        
        super.init()
        
        /*
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
 
 */
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(infoColorCode, forKey: PropertyKey.infoColorCodeKey)
        aCoder.encode(textColorCode, forKey: PropertyKey.textColorCodeKey)
        aCoder.encode(contrastCode, forKey: PropertyKey.contrastCodeKey)
        aCoder.encode(sortCode, forKey: PropertyKey.sortCodeKey)
        aCoder.encode(minContrastRatioNumber, forKey: PropertyKey.minContrastRatioNumberKey)
        aCoder.encode(textR, forKey: PropertyKey.textRKey)
        aCoder.encode(textG, forKey: PropertyKey.textGKey)
        aCoder.encode(textB, forKey: PropertyKey.textBKey)
        aCoder.encode(seekBarPosition, forKey: PropertyKey.seekBarPositionKey)
        aCoder.encode(currentProgress, forKey: PropertyKey.currentProgressKey)
        aCoder.encode(progress, forKey: PropertyKey.progressKey)
        
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        let infoColorCode = aDecoder.decodeInteger(forKey: PropertyKey.infoColorCodeKey)
        let textColorCode = aDecoder.decodeInteger(forKey: PropertyKey.textColorCodeKey)
        let contrastCode = aDecoder.decodeInteger(forKey: PropertyKey.contrastCodeKey)
        let sortCode = aDecoder.decodeInteger(forKey: PropertyKey.sortCodeKey)
        let minContrastRatioNumber = aDecoder.decodeFloat(forKey: PropertyKey.minContrastRatioNumberKey)
        let textR = aDecoder.decodeFloat(forKey: PropertyKey.textRKey)
        let textG = aDecoder.decodeFloat(forKey: PropertyKey.textGKey)
        let textB = aDecoder.decodeFloat(forKey: PropertyKey.textBKey)
        let seekBarPosition = aDecoder.decodeFloat(forKey: PropertyKey.seekBarPositionKey)
        let currentProgress = aDecoder.decodeInteger(forKey: PropertyKey.currentProgressKey)
        let progress = aDecoder.decodeInteger(forKey: PropertyKey.progressKey)
        /*
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? Int
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        */
        // Must call designated initializer.
        self.init(infoColorCode: infoColorCode, textColorCode: textColorCode, contrastCode: contrastCode, sortCode: sortCode, minContrastRatioNumber: minContrastRatioNumber,
                  textR: textR, textG: textG, textB: textB, seekBarPosition: seekBarPosition, currentProgress: currentProgress, progress: progress)
    }


}
