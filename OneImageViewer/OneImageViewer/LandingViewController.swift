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

        // Set up ImageView
        let TintColorOfimageTemplate = UIColor.white
        if let image = UIImage(named: Assets.iconPhoto.rawValue)?.withRenderingMode(.alwaysTemplate) {
            imageView = UIImageView(image: image)
            imageView.contentMode = .center
            imageView.image = image
            imageView.tintColor = TintColorOfimageTemplate
        }
        imageView.isUserInteractionEnabled = true

        // Set up ScrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 375, height: 590))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)

        // ZoomScale Setting
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.0

    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        // ScrollView
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77.0).isActive = true

        // ImageView
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
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

// MARK: - Selector
private extension Selector {

    static let loadImageButtonTapped = #selector(LandingViewController.loadImageButtonTapped)

}
