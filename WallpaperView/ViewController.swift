//
//  ViewController.swift
//  WallpaperView
//
//  Created by Ahmed Khattak on 06/07/2017.
//  Copyright © 2017 Ahmed Khattak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //constraints
    
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraintsForSize(size : view.bounds.size)
        setInitialOffset()
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
    
    func makeNavbarTitleColorWhite(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }

    
    func makeStatusbarTextColorWhite(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func setUpImage(){
        imageView.image = UIImage(named: "jakob")
    }
    
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



extension ViewController:UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(scrollView.zoomScale)
        updateConstraintsForSize(size : view.bounds.size)
    }
    
}





