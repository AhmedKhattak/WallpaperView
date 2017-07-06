//
//  ViewController.swift
//  WallpaperView
//
//  Created by Ahmed Khattak on 06/07/2017.
//  Copyright © 2017 Ahmed Khattak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func makeNavbarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func makeToolbarTransparent(){
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .bottom, barMetrics: .default)
        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .bottom)

    }

}





