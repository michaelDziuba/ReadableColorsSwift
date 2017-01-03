//
//  ViewController.swift
//  Practice 2.0
//
//  Created by cdu on 2016-07-17.
//  Copyright © 2016 Michael Dziuba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainNavHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainViewWidth: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet var labels: [UILabel]!
    
    
    @IBOutlet weak var colorLabelsHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var colorScanSlider: UISlider!
   
    @IBOutlet weak var colorInfoSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var textColorSegmentedControl: UISegmentedControl!
    
    
    
    let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var scale = UIScreen.main.scale
    var screenHeight: Double = 0.0
    var screenWidth: Double = 0.0
    var screenXorigin: Double = 0.0
    var screenYorigin: Double = 0.0
    
    
    var contrastCode: Int = 1
    
    var progress: Int = 0
    var progressScaleFactor: Float = 0.0
    var sortCode: Int = 1
    var sortCode1: Int = 0
    var sortCode2: Int = 0
    var sortCode3: Int = 0
    var sortCode4: Int = 0
    
    var seekBarPosition: Float = 0.0
    var currentProgress: Int = 0
    
    var infoColorCode: Int = 2
    
    
    var arrayHSVColors = Array<[Float]>(repeating: Array(repeating: 0.0, count: 3), count: 7400)
    var count: Int = 0
    let COLORS_DISPLAY: Int = 68;
    
    var textColorCode: Int = 0
    var textR: Float = 255.0
    var textG: Float = 255.0
    var textB: Float = 255.0
    var minContrastRatioNumber: Float = 7.0;
    
    var contrastRatioNumber: Float = 0.0;
    
    let RGB_THRESHOLD: Float = 0.03928;
    let RGB_NUMERATOR_1: Float = 12.92;
    let RGB_OFFSET: Float = 0.055;
    let RGB_NUMERATOR_2: Float = 1.055;
    let RGB_EXPONENT: Float = 2.4;
    
    let R_FACTOR: Float = 0.2126;
    let G_FACTOR: Float = 0.7152;
    let B_FACTOR: Float = 0.0722;
    
    let RGB_MAX: Float = 255.0;
  
    
    

    var readableColors: ReadableColors?
    var isFromOptionsViewController: Bool = false
   
    var labelHeight: CGFloat = 17.0
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        
        
        screenHeight = Double(screenSize.height)
        screenWidth = Double(screenSize.width)
        screenXorigin = Double(screenSize.origin.x)
        screenYorigin = Double(screenSize.origin.y)
        
        if(screenWidth < screenHeight || screenWidth > 667.0) {
            mainNavHeight.constant = 44
        }else{
            mainNavHeight.constant = 34
        }
        
       
        if(screenHeight >= 667.0 && screenHeight < 736.0){
            colorLabelsHeight.constant = CGFloat(screenHeight * 0.03)
            labelHeight = CGFloat(screenHeight * 0.03)
        }else if(screenHeight >= 736.0 && screenHeight < 1024.0){
            colorLabelsHeight.constant = CGFloat(screenHeight * 0.031)
            labelHeight = CGFloat(screenHeight * 0.031)
         }else if(screenHeight >= 1024.0 && screenHeight < 1366.0){
            colorLabelsHeight.constant = CGFloat(screenHeight * 0.035)
            labelHeight = CGFloat(screenHeight * 0.035)
         }else if(screenHeight >= 1366.0){
            colorLabelsHeight.constant = CGFloat(screenHeight * 0.04)
            labelHeight = CGFloat(screenHeight * 0.04)
        }
        
        
        var labelTextSize = labelHeight * 0.65
        labelTextSize = labelTextSize < 14 ? labelTextSize : 14
        
        formatColorLabels(labelTextSize)
        
        
        setStatusBarBackgroundColor(UIColor(colorLiteralRed: 0.95, green: 1.0, blue: 0.95, alpha: 1.0))
        
    
        if(screenHeight < 600.0){
            mainViewHeight.constant = screenSize.height + (600.0 - screenSize.height)
        }else{
            mainViewHeight.constant = screenSize.height
        }
        mainViewWidth.constant = screenSize.width
        
        
     
       

        readableColors = loadReadableColors()
        
        if(readableColors == nil){
            colorInfoSegmentedControl.selectedSegmentIndex = infoColorCode
            textColorSegmentedControl.selectedSegmentIndex = textColorCode
            setMinContrastRatio()
            
            readableColors = ReadableColors(infoColorCode: infoColorCode, textColorCode: textColorCode, contrastCode: contrastCode,
                                            sortCode: sortCode, minContrastRatioNumber: minContrastRatioNumber, textR: textR,
                                            textG: textG, textB: textB, seekBarPosition: seekBarPosition,
                                            currentProgress: currentProgress, progress: progress)
            saveReadableColors()
            
           
        }else{
           
            
            infoColorCode = (readableColors?.infoColorCode)!
            textColorCode = (readableColors?.textColorCode)!
            
            colorInfoSegmentedControl.selectedSegmentIndex = infoColorCode
            textColorSegmentedControl.selectedSegmentIndex = textColorCode
            
            if(isFromOptionsViewController){
                readableColors?.contrastCode = contrastCode
                readableColors?.sortCode = sortCode
                setMinContrastRatio()
                readableColors?.minContrastRatioNumber = minContrastRatioNumber
                saveReadableColors()
            }else{
                contrastCode = (readableColors?.contrastCode)!
                sortCode = (readableColors?.sortCode)!
                setMinContrastRatio()
                minContrastRatioNumber = (readableColors?.minContrastRatioNumber)!
            }
            
            textR = (readableColors?.textR)!
            textG = (readableColors?.textG)!
            textB = (readableColors?.textB)!
            seekBarPosition = (readableColors?.seekBarPosition)!
            currentProgress = (readableColors?.currentProgress)!
            progress = (readableColors?.progress)!
        }
        
        

        recreateAllForNewSettings()
        
    }
    
    
    
 /*
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        saveReadableColors()
    }
  */  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        saveReadableColors()
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ViewControllerOptions"){
            let viewControllerOptions = segue.destination as! ViewControllerOptions
            viewControllerOptions.contrastCode = self.contrastCode
            viewControllerOptions.sortCode = self.sortCode
        }
        
    }
    
    
    
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        super.viewWillTransition(to: size, with: coordinator)
        
        if((screenWidth < 768.0 || screenHeight < 768.0) && screenHeight > screenWidth) {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }else{
        
            screenWidth = Double(size.width)
            screenHeight = Double(size.height)
        
            mainViewWidth.constant = CGFloat(screenWidth)
            if(screenHeight < 600.0){
                mainViewHeight.constant = size.height + (600.0 - size.height)
            }else{
                mainViewHeight.constant = size.height
            }
            
            
            
            if(screenHeight >= 667.0 && screenHeight < 736.0){
                colorLabelsHeight.constant = CGFloat(screenHeight * 0.03)
                labelHeight = CGFloat(screenHeight * 0.03)
            }else if(screenHeight >= 736.0 && screenHeight < 1024.0){
                colorLabelsHeight.constant = CGFloat(screenHeight * 0.031)
                labelHeight = CGFloat(screenHeight * 0.031)
            }else if(screenHeight >= 1024.0 && screenHeight < 1366.0){
                colorLabelsHeight.constant = CGFloat(screenHeight * 0.035)
                labelHeight = CGFloat(screenHeight * 0.035)
            }else if(screenHeight >= 1366.0){
                colorLabelsHeight.constant = CGFloat(screenHeight * 0.04)
                labelHeight = CGFloat(screenHeight * 0.04)
            }
            
            
            var labelTextSize = labelHeight * 0.7
            labelTextSize = labelTextSize > 11.5 ? labelTextSize : 11.5
            
            formatColorLabels(labelTextSize)
            
            
            
        }
 
            
            
        
        
        
        
        
        
        
        if(screenWidth < screenHeight || screenWidth > 667.0) {
            mainNavHeight.constant = 44
        }else{
            mainNavHeight.constant = 34
        }
       
        
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    
    
    func setStatusBarBackgroundColor(_ color: UIColor) {
        if (statusBar != nil){
            statusBar!.backgroundColor = color
        }
    }
    
    
    
  
    override var shouldAutorotate : Bool {
        if((screenWidth < 768.0 || screenHeight < 768.0) && screenHeight > screenWidth) {
            return false
        }else{
            return true
        }
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if((screenWidth < 768.0 || screenHeight < 768.0) && screenHeight > screenWidth) {
            return UIInterfaceOrientationMask.portrait
        }else{
            return UIInterfaceOrientationMask.allButUpsideDown
        }
        
    }
  
   
    
    
    
    
    @IBAction func colorScanSliderHandler(_ sender: UISlider) {
        progress = Int(round(sender.value * 100))
        seekBarPosition = sender.value
        currentProgress = Int(Float(progress) * progressScaleFactor)
        readableColors!.seekBarPosition = seekBarPosition
        readableColors!.currentProgress = currentProgress
        readableColors!.progress = progress
        saveReadableColors()
        makeBackgroundColor(currentProgress)
        showColorInfo()
    }
    
    
    func setProgressScaleFactor(){
        if(textColorCode == 0 && minContrastRatioNumber == 3.0){
            progressScaleFactor = 0.70
        }else if(textColorCode == 1 && minContrastRatioNumber == 3.0){
            progressScaleFactor = 1.00
        }else if(textColorCode == 0 && minContrastRatioNumber == 4.5){
            progressScaleFactor = 0.44
        }else if(textColorCode == 1 && minContrastRatioNumber == 4.5){
            progressScaleFactor = 0.80
        }else if(textColorCode == 0 && minContrastRatioNumber == 7.0){
            progressScaleFactor = 0.23
        }else if(textColorCode == 1 && minContrastRatioNumber == 7.0){
            progressScaleFactor = 0.535
        }
    }
    
    
    func recreateAllForNewSettings(){
        makeColorArray();
        sortColorArray(sortCode);
        setProgressScaleFactor();
        
        currentProgress = Int(Float(progress) * progressScaleFactor)
        colorScanSlider.setValue(seekBarPosition, animated: false)
        makeBackgroundColor(currentProgress);
        makeTextColor(textR, textG: textG, textB: textB)
        showColorInfo()
    }
    
    
    
    
    
    @IBAction func colorInforSegmentedControlHandler(_ sender: UISegmentedControl) {
        infoColorCode = sender.selectedSegmentIndex
        readableColors!.infoColorCode = infoColorCode
        saveReadableColors()
        recreateAllForNewSettings()
    }

    
    @IBAction func textColorSegmentedControlHandler(_ sender: UISegmentedControl) {
        textColorCode = sender.selectedSegmentIndex
        readableColors!.textColorCode = textColorCode
        
        switch(textColorCode){
            case 0: textR = 255; textG = 255; textB = 255
            case 1: textR = 0; textG = 0; textB = 0
            default: break
        }
        
        readableColors!.textR = textR
        readableColors!.textG = textG
        readableColors!.textB = textB
        saveReadableColors()
        recreateAllForNewSettings()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func luminance(_ valueR: Float, valueG: Float, valueB: Float) -> Float {
        
        let sRBG_R: Float = valueR / RGB_MAX;
        let sRGB_R_base: Float = (sRBG_R + RGB_OFFSET) / RGB_NUMERATOR_2;
        let sRBG_G: Float = valueG / RGB_MAX;
        let sRGB_G_base: Float = (sRBG_G + RGB_OFFSET) / RGB_NUMERATOR_2;
        let sRBG_B: Float = valueB / RGB_MAX;
        let sRGB_B_base: Float = (sRBG_B + RGB_OFFSET) / RGB_NUMERATOR_2;
        
        let R: Float = sRBG_R <= RGB_THRESHOLD ? sRBG_R / RGB_NUMERATOR_1 : pow(sRGB_R_base, RGB_EXPONENT);
        let G: Float = sRBG_G <= RGB_THRESHOLD ? sRBG_G / RGB_NUMERATOR_1 : pow(sRGB_G_base, RGB_EXPONENT);
        let B: Float = sRBG_B <= RGB_THRESHOLD ? sRBG_B / RGB_NUMERATOR_1 : pow(sRGB_B_base, RGB_EXPONENT);
        
        let luminance: Float = R_FACTOR * R + G_FACTOR * G + B_FACTOR * B;
        
        return luminance;
    }
    
    
    //minimum contrastRatio is 7:1 (https://www.w3.org/TR/WCAG20-TECHS/G17.html)
    func contrastRatio(_ textR: Float, textG: Float, textB: Float, backgroundR: Float, backgroundG: Float, backgroundB: Float) -> Float {
        
        let valueR: Float = backgroundR
        let valueG: Float = backgroundG
        let valueB: Float = backgroundB
        
        var contrastRatio: Float = (luminance(textR, valueG: textG, valueB: textB) + 0.05) / (luminance (valueR, valueG: valueG, valueB: valueB) + 0.05);
        
        contrastRatio = contrastRatio < 1 ? 1 / contrastRatio : contrastRatio;
        
        return contrastRatio;
    }
    
    
    /**
     http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
     * Converts an RGB color value to HSV. Conversion formula
     * adapted from http://en.wikipedia.org/wiki/HSV_color_space.
     * Assumes r, g, and b are contained in the set [0, 255] and
     * returns h, s, and v in the set [0, 1].
     *
     * @param   Number  r       The red color value
     * @param   Number  g       The green color value
     * @param   Number  b       The blue color value
     * @return  Array           The HSV representation
     */
    
    func rgbToHsv(_ r: Int, g: Int, b: Int) -> (h: Float, s: Float, v: Float) {
        let r: Float = Float(r) / 255
        let g: Float = Float(g) / 255
        let b: Float = Float(b) / 255
        
        let maximum: Float = max(r, g, b)
        let minimum: Float = min(r, g, b)
        //var h, s, v = max;
        
        let d = maximum - minimum
        var h: Float = 0
        let s: Float = (maximum == 0) ? 0 : d / maximum
        let v: Float = maximum
        
        if(maximum == minimum){
            h = 0; // achromatic
        }else{
            switch(maximum){
            case r: h = (g - b) / d + (g < b ? 6 : 0)
            case g: h = (b - r) / d + 2
            case b: h = (r - g) / d + 4
            default: break
            }
            h /= 6
        }
        
        h *= 360  // converts from % to degrees
        
        return (h, s, v)
    }
    
    
    /**
     * Converts an HSV color value to RGB. Conversion formula
     * adapted from http://en.wikipedia.org/wiki/HSV_color_space.
     * Assumes h, s, and v are contained in the set [0, 1] and
     * returns r, g, and b in the set [0, 255].
     *
     * @param   Number  h       The hue
     * @param   Number  s       The saturation
     * @param   Number  v       The value
     * @return  Array           The RGB representation
     */
    func hsvToRgb(_ h: Float, s: Float, v: Float) -> (r: Float, g: Float, b: Float) {
        let h = h / 360 //converts from degrees to %
        
        var r: Float = 0
        var g: Float = 0
        var b: Float = 0
        
        let i: Float = floor(h * 6)
        let f: Float = h * 6 - i
        let p: Float = v * (1 - s)
        let q: Float = v * (1 - f * s)
        let t: Float = v * (1 - (1 - f) * s)
        
        switch(i.truncatingRemainder(dividingBy: 6)){
        case 0: r = v; g = t; b = p
        case 1: r = q; g = v; b = p
        case 2: r = p; g = v; b = t
        case 3: r = p; g = q; b = v
        case 4: r = t; g = p; b = v
        case 5: r = v; g = p; b = q
        default: break
        }
        
        return (round(r * 255), round(g * 255), round(b * 255))
    }
    
    
    
    func makeColorArray(){
        arrayHSVColors =  Array<[Float]>(repeating: Array(repeating: 0.0, count: 4), count: 7400)
        count = 0
        
        for i in stride(from: 0, to: 256, by: 15){
            for j in stride(from: 0, to: 256, by: 5){
                for k in stride(from: 0, to: 256, by: 30){
                    contrastRatioNumber = contrastRatio(textR, textG: textG, textB: textB, backgroundR: Float(i), backgroundG: Float(j), backgroundB: Float(k))
                    if(contrastRatioNumber >= minContrastRatioNumber){
                        let (h, s, v) = rgbToHsv(i, g: j, b: k)
                        arrayHSVColors[count][0] = h
                        arrayHSVColors[count][1] = s
                        arrayHSVColors[count][2] = v
                        arrayHSVColors[count][3] = contrastRatioNumber
                        count += 1
                    }
                }
            }
        }
    }
    
    
    func sortColorArray(_ sortCode: Int){
//        arrayHSVColors.sort {
//            $0[sortCode] > $1[sortCode]
//        }
        
        switch (sortCode) {
        case 0: sortCode1 = 0; sortCode2 = 2; sortCode3 = 1; sortCode4 = 3
        case 1: sortCode1 = 1; sortCode2 = 2; sortCode3 = 0; sortCode4 = 3
        case 2: sortCode1 = 2; sortCode2 = 1; sortCode3 = 0; sortCode4 = 3
        case 3: sortCode1 = 3; sortCode2 = 1; sortCode3 = 2; sortCode4 = 0
        default: break
        }
        
        arrayHSVColors.sort{
            if $0[sortCode1] > $1[sortCode1] {
                return true
            }else if $0[sortCode1] < $1[sortCode1] {
                return false
            }else if $0[sortCode1] == $1[sortCode1] {
                if $0[sortCode2] > $1[sortCode2] {
                    return true
                }else if $0[sortCode2] < $1[sortCode2] {
                    return false
                }else if $0[sortCode2] == $1[sortCode2] {
                    if $0[sortCode3] > $1[sortCode3] {
                        return true
                    }else if $0[sortCode3] < $1[sortCode3] {
                        return false
                    }else if $0[sortCode3] == $1[sortCode3] {
                        if $0[sortCode4] > $1[sortCode4] {
                            return true
                        }else if $0[sortCode4] < $1[sortCode4] {
                            return false
                        }else if $0[sortCode4] == $1[sortCode4] {
                            return false
                        }
                    }
                }
            }
            return false
        }
        
    }
    
    
    func makeTextColor(_ textR: Float, textG: Float, textB: Float){
        for i in 0..<COLORS_DISPLAY {
            labels[i].textColor = UIColor(red: textR, green: textG, blue: textB)
            //for(int i = 0; i < COLORS_DISPLAY; i++) {
            //((TextView) (colorGridLayout.getChildAt(i))).setTextColor(Color.rgb(textR, textG, textB));
        }
    }
    
    
    func makeBackgroundColor(_ progress: Int){
        for i in 0..<COLORS_DISPLAY {
            let (r, g, b) = hsvToRgb(arrayHSVColors[progress * COLORS_DISPLAY + i][0], s: arrayHSVColors[progress * COLORS_DISPLAY + i][1], v: arrayHSVColors[progress * COLORS_DISPLAY + i][2])
            labels[i].backgroundColor = UIColor(red: r, green: g, blue: b)
        }
    }
    
    
    
    
    
    func showColorInfo(){
        switch(infoColorCode){
        case 0: makeHexCode(currentProgress)
        case 1: makeRGBCode(currentProgress)
        case 2: makeContrastRatio(currentProgress)
        default: break
        }
    }
    
    
    
    func makeHexCode(_ progress: Int){
        
        var hexNumber1: String
        var hexNumber2: String
        var hexNumber3: String
        
        for i in 0..<COLORS_DISPLAY {
            let (r, g, b) = hsvToRgb(arrayHSVColors[progress * COLORS_DISPLAY + i][0], s: arrayHSVColors[progress * COLORS_DISPLAY + i][1], v: arrayHSVColors[progress * COLORS_DISPLAY + i][2])
            
            hexNumber1 = String(format:"%2X", Int(r)).trim()
            hexNumber1 = "#" + (hexNumber1.characters.count == 1 ? "0" + hexNumber1 : hexNumber1)
            hexNumber2 = String(format:"%2X", Int(g)).trim()
            hexNumber1 += (hexNumber2.characters.count == 1 ? "0" + hexNumber2 : hexNumber2)
            hexNumber3 = String(format:"%2X", Int(b)).trim()
            hexNumber1 += (hexNumber3.characters.count == 1 ? "0" + hexNumber3 : hexNumber3)
            
            labels[i].text = hexNumber1
        }
    }
    
    
    func makeRGBCode(_ progress: Int){
        for i in 0..<COLORS_DISPLAY {
            let (r, g, b) = hsvToRgb(arrayHSVColors[progress * COLORS_DISPLAY + i][0], s: arrayHSVColors[progress * COLORS_DISPLAY + i][1], v: arrayHSVColors[progress * COLORS_DISPLAY + i][2])
            
            labels[i].text = String(format: "%.0f,%.0f,%.0f", r, g, b)
        }
    }
    
    
    func makeContrastRatio(_ progress: Int){
        for i in 0..<COLORS_DISPLAY {
            let (r, g, b) = hsvToRgb(arrayHSVColors[progress * COLORS_DISPLAY + i][0], s: arrayHSVColors[progress * COLORS_DISPLAY + i][1], v: arrayHSVColors[progress * COLORS_DISPLAY + i][2])
            
            let contrastRatioNumber: Float = contrastRatio(textR, textG: textG, textB: textB, backgroundR: r, backgroundG: g, backgroundB: b)
            labels[i].text = String(format: "%.2f", contrastRatioNumber)
        }
    }
    

    
    
     func saveReadableColors() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(readableColors!, toFile: ReadableColors.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save readableColors...")
        }
    
    }
    
    
    func loadReadableColors() -> ReadableColors? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ReadableColors.ArchiveURL.path) as? ReadableColors
    }
    
    
    func setMinContrastRatio(){
        switch(contrastCode){
        case 0: minContrastRatioNumber = 3.0
        case 1: minContrastRatioNumber = 4.5
        case 2: minContrastRatioNumber = 7.0
        default: break
        }
    }
    
    
    func formatColorLabels(_ labelTextSize: CGFloat){
        for i in 0..<68 {
            labels[i].layer.borderColor = UIColor(colorLiteralRed: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
            labels[i].layer.borderWidth = 1.0
            //labels[i].font = labels[i].font.fontWithSize(labelTextSize)
            labels[i].font = UIFont.boldSystemFont(ofSize: labelTextSize)
            
        }
    }
    
}




/**
 * http://www.codingexplorer.com/create-uicolor-swift/
 */
extension UIColor {
    convenience init(red: Float, green: Float, blue: Float) {
        
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}


extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

