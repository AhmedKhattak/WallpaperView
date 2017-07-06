//
//  ViewController.swift
//  WallpaperView
//
//  Created by Ahmed Khattak on 06/07/2017.
//  Copyright © 2017 Ahmed Khattak. All rights reserved.
//  
//  Wallpaper credit : https://unsplash.com/@jakobowens1
//

import UIKit

class ViewController: UIViewController {

    //views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //constraints
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavbarTransparent()
        makeToolbarTransparent()
        makeNavbarTitleColorWhite()
        makeStatusbarTextColorWhite()
        setUpImage()
        setUpScrollView()
        setZoomScale()
        updateConstraintsForSize(size: self.view.frame.size)
        setInitialOffset()
        
    }

  
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraintsForSize(size : view.bounds.size)
        setInitialOffset()
    }
    
    
    //Makes the navbarr transparent
    func makeNavbarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    //Makes the toolbar transparent
    func makeToolbarTransparent(){
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .bottom, barMetrics: .default)
        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .bottom)

    }
    
    //Makes the navbar title color white
    func makeNavbarTitleColorWhite(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }

    
    //Makes the status bar text white
    func makeStatusbarTextColorWhite(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    //Setup imageView
    func setUpImage(){
        imageView.image = UIImage(named: "jakob")
    }
    
    //Setup all the scrollView particulars
    func setUpScrollView(){
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
    }
    
    
    
    /// Sets the initial offset of the image i.e centers it vertically and horizontaly
    /// inside the scroll view's viewing area
    private func setInitialOffset(){
        let  newContentOffsetX = (scrollView.contentSize.width - scrollView.frame.size.width) / 2;
        let  newContentOffsetY = (scrollView.contentSize.height - scrollView.frame.size.height) / 2;
        let point = CGPoint(x: newContentOffsetX, y: newContentOffsetY)
        scrollView.contentOffset = point
    }
    
    
    /// Make the image center in scrollview by changing its constraints
    fileprivate func updateConstraintsForSize(size: CGSize) {
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    
    //sets the zoom scale needed to make image fit inside the devices view
    private func setZoomScale() {
        
        let minScale = (self.view.bounds.size.height) / (self.imageView.image?.size.height)!
        
        if (self.imageView.image?.size.height)! > self.view.bounds.size.height {
            
            scrollView.minimumZoomScale = minScale
            scrollView.zoomScale = minScale
            scrollView.maximumZoomScale = 8
            scrollView.setZoomScale(minScale, animated: true)
            print(minScale)
            
        }else{
            
            scrollView.minimumZoomScale = minScale
            scrollView.zoomScale = minScale
            scrollView.maximumZoomScale = minScale + 8
            scrollView.setZoomScale(minScale, animated: true)
            
        }
        
        
    }
    
    
}


//Extension handles delegate duties
extension ViewController:UIScrollViewDelegate {
    
    //Returns the view used for zooming
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //Event is fired when zoom occurs
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(scrollView.zoomScale)
        updateConstraintsForSize(size : view.bounds.size)
    }
    
}





