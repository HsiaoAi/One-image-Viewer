//
//  LandingViewController.swift
//  OneImageViewer
//
//  Created by Hsiao Ai LEE on 23/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Properties
    @IBOutlet weak var pickUpButton: UIButton!
    let imagePicker = UIImagePickerController()
    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickImageButton()
        setUpScrollViewAndImageView()
        imagePicker.delegate = self

    }

}
extension LandingViewController: UIScrollViewDelegate {

    func setUpScrollViewAndImageView() {
        imageView = UIImageView(image: UIImage(named: "icon_photo"))
        
        let TintColorOfimageTemplate = UIColor.white
        if let image = UIImage(named: "icon_photo")?.withRenderingMode(.alwaysTemplate) {
            print("here")
            imageView.contentMode = .center
            imageView.image = image
            imageView.tintColor = TintColorOfimageTemplate
            //imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        }
        //設定滾動區域及大小
        print(view.bounds)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 375, height: 590))
        scrollView.contentSize = imageView.bounds.size

        view.addSubview(scrollView)
        scrollView.addSubview(imageView)

        //當裝置旋轉時，會重新調整大小
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        //1.將滾動區域的位置從原點在左上角改為(1000, 450)
        scrollView.contentOffset = CGPoint(x: 1000, y: 450)

        //2. 縮放功能需要指定delegate self 跟縮放比例
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 10.0
        scrollView.zoomScale = 2.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        
        scrollView.zoomScale = minScale
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(view.bounds.size)
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    
}

// UI
extension LandingViewController {
    func setUpPickImageButton() {
        // Two colors background
        pickUpButton.backgroundColor = UIColor.CustomTheme.black43
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.pickUpButton.bounds
        gradientLayer.colors = [
            UIColor.CustomTheme.white5.cgColor,
            UIColor.CustomTheme.white5.cgColor,
            UIColor.CustomTheme.black43.cgColor,
            UIColor.CustomTheme.black43.cgColor
        ]
        gradientLayer.locations = [0, 0.5, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        pickUpButton.layer.addSublayer(gradientLayer)

        // Shadow
        pickUpButton.layer.shadowColor = UIColor.CustomTheme.black25.cgColor
        pickUpButton.layer.shadowOpacity = 1.0
        pickUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        pickUpButton.layer.shadowRadius = 4

        // Target-Action
        pickUpButton.addTarget(self, action: .loadImageButtonTapped, for: .touchUpInside)

        self.view.bringSubview(toFront: pickUpButton)
    }

    @objc func loadImageButtonTapped(_ sender: Any) {

        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

//    func setUpImageView() {
//        let TintColorOfimageTemplate = UIColor.white
//        if let image = UIImage(named: "icon_photo")?.withRenderingMode(.alwaysTemplate) {
//            imageView.contentMode = .center
//            imageView.image = image
//            imageView.tintColor = TintColorOfimageTemplate
//            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
//            self.view.addSubview(imageView)
//        }
//
//    }
}

// MARK: - UIImagePickerControllerDelegate Methods
extension LandingViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//

// MARK: - Selector
private extension Selector {

    static let loadImageButtonTapped = #selector(LandingViewController.loadImageButtonTapped)

}
