//
//  ViewControllerOptions.swift
//  Practice 2.0
//
//  Created by cdu on 2016-07-17.
//  Copyright © 2016 Michael Dziuba. All rights reserved.
//

import UIKit

class ViewControllerOptions: UIViewController {
    
   
    @IBOutlet weak var optionsNavHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var optionsViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var optionsViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var minimumContrastSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var sortBySegmentedControl: UISegmentedControl!
    
    
    var contrastCode: Int = 1
    var sortCode: Int = 1
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var scale = UIScreen.main.scale
    var screenHeight: Double = 0.0
    var screenWidth: Double = 0.0
    var screenXorigin: Double = 0.0
    var screenYorigin: Double = 0.0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        minimumContrastSegmentedControl.selectedSegmentIndex = contrastCode
        sortBySegmentedControl.selectedSegmentIndex = sortCode
        
        
        
        screenHeight = Double(screenSize.height)
        screenWidth = Double(screenSize.width)
        screenXorigin = Double(screenSize.origin.x)
        screenYorigin = Double(screenSize.origin.y)
        
        if(screenWidth < screenHeight || screenWidth > 667.0) {
            optionsNavHeight.constant = 44
        }else{
            optionsNavHeight.constant = 34
        }
        
        optionsViewWidth.constant = screenSize.width
        optionsViewHeight.constant = screenSize.height
        
    }
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
        
    }
    

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       let mainViewController = segue.destination as! ViewController
        
        mainViewController.contrastCode = self.contrastCode
        mainViewController.sortCode = self.sortCode
        mainViewController.isFromOptionsViewController = true
        
    }
    
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        super.viewWillTransition(to: size, with: coordinator)
        
        if((screenWidth < 768.0 || screenHeight < 768.0) && screenHeight > screenWidth) {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }else{
            
            screenWidth = Double(size.width)
            screenHeight = Double(size.height)
            
            optionsViewWidth.constant = CGFloat(screenWidth)
            if(screenHeight < 600.0){
                optionsViewHeight.constant = size.height + (600.0 - size.height)
            }else{
                optionsViewHeight.constant = size.height
            }
            
            
        }
        
        if(screenWidth < screenHeight || screenWidth > 667.0) {
            optionsNavHeight.constant = 44
        }else{
            optionsNavHeight.constant = 34
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
    
    
    
    @IBAction func minimumContrastSegmentedControlHandler(_ sender: UISegmentedControl) {
        contrastCode = sender.selectedSegmentIndex
    }
    
    
    
    @IBAction func sortBySegmentedControlHandler(_ sender: UISegmentedControl) {
        sortCode = sender.selectedSegmentIndex
    }
    
    
}
