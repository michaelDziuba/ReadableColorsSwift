//
//  ViewControllerAbout.swift
//  Practice 2.0
//
//  Created by Michael Dziuba on 2016-07-17.
//  Copyright © 2016 Michael Dziuba. All rights reserved.
//

import UIKit

class ViewControllerAbout: UIViewController {
    
    
    @IBOutlet weak var aboutNavHeight: NSLayoutConstraint!
    
    @IBOutlet weak var aboutViewWidth: NSLayoutConstraint!
    @IBOutlet weak var aboutViewHeight: NSLayoutConstraint!
    
    let screenSize: CGRect = UIScreen.main.bounds
    var scale = UIScreen.main.scale
    var screenHeight: Double = 0.0
    var screenWidth: Double = 0.0
    var screenXorigin: Double = 0.0
    var screenYorigin: Double = 0.0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        screenHeight = Double(screenSize.height)
        screenWidth = Double(screenSize.width)
        screenXorigin = Double(screenSize.origin.x)
        screenYorigin = Double(screenSize.origin.y)
        
        if(screenWidth < screenHeight || screenWidth > 667.0) {
            aboutNavHeight.constant = 44
        }else{
            aboutNavHeight.constant = 34
        }
        
        aboutViewWidth.constant = CGFloat(screenWidth)
        if(screenHeight < 700.0){
            aboutViewHeight.constant = CGFloat(screenHeight + (700.0 - screenHeight))
        }else{
            aboutViewHeight.constant = CGFloat(screenHeight)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func webLink(_ sender: UIButton) {
        if let url = URL(string: "https://www.w3.org/TR/2008/REC-WCAG20-20081211/#visual-audio-contrast") {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func webLink2(_ sender: UIButton) {
        if let url = URL(string: "https://www.w3.org/TR/WCAG20-TECHS/G17.html") {
            UIApplication.shared.openURL(url)
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //let mainViewController = segue.destinationViewController as! ViewController
        
        //mainViewController.string = "About"
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        super.viewWillTransition(to: size, with: coordinator)
        
        if((screenWidth < 768.0 || screenHeight < 768.0) && screenHeight > screenWidth) {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }else{
            
            screenWidth = Double(size.width)
            screenHeight = Double(size.height)
            
            aboutViewWidth.constant = CGFloat(screenWidth)
            if(screenHeight < 600.0){
                aboutViewHeight.constant = size.height + (600.0 - size.height)
            }else{
                aboutViewHeight.constant = size.height
            }
        }
        
        if(screenWidth < screenHeight || screenWidth > 667.0) {
            aboutNavHeight.constant = 44
        }else{
            aboutNavHeight.constant = 34
        }
        
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return false
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

}
