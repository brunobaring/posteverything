//
//  CreatePostController.swift
//  RioFatos
//
//  Created by Bruno Baring on 13/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit
import ImagePicker
import ImageSlideShowSwift
import IQKeyboardManagerSwift

class CreatePostController: UIViewController
{
    
    @IBOutlet weak var addPhotoCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var titleCharLeftLabel: UILabel!
    @IBOutlet weak var descriptionCharLeftLabel: UILabel!
    
    var createPostPresenter = CreatePostPresenter()
    var createPostPhotoProtocols : CreatePostPhotoProtocols! = nil
    var titleAndDescriptionDelegates : CreatePostTitleAndDescriptionDelegate! = nil

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupProtocols()
        descriptionTextView.keyboardDistanceFromTextField = 120
        
    }
    
    @IBAction func didTouchBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupProtocols()
    {
        createPostPhotoProtocols = CreatePostPhotoProtocols()
        createPostPhotoProtocols.delegate = self

        addPhotoCollectionView.delegate = createPostPhotoProtocols
        addPhotoCollectionView.dataSource = createPostPhotoProtocols
        addPhotoCollectionView.reloadData()

        titleAndDescriptionDelegates = CreatePostTitleAndDescriptionDelegate()
        titleAndDescriptionDelegates.delegate = self
        
        titleTextField.delegate = titleAndDescriptionDelegates
        descriptionTextView.delegate = titleAndDescriptionDelegates
    }
    
    @IBAction func sendButtonTouched(_ sender: Any) {
        self.startLoading()
        createPostPresenter.sendPost { (error) in
            self.stopLoading()
            
            if let error = error {
                self.handleError(error)
                self.presentAlert(title: "Erro", message: "Os campos devem ser preenchidos")
                return
            }
            self.presentAlert(title: "Sucesso", message: "Post enviado")
        }
        
    }
}


extension CreatePostController: CreatePostCharLeftProtocol
{
    
    func newTitleCharQty(_ qtd: Int)
    {
        titleCharLeftLabel.text = "\(qtd) characters left"
        createPostPresenter.updateTitle(titleTextField.text!)
    }

    
    func newDescriptionCharQty(_ qtd: Int)
    {
        descriptionCharLeftLabel.text = "\(qtd) characters left"
        createPostPresenter.updateDescription(descriptionTextView.text)
    }
    
}


extension CreatePostController: MyImagePickerDelegate
{
    
    func didTouchImagePickerAddButton()
    {
        var config = Configuration()
        config.recordLocation = false
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "No images available"
        
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = createPostPhotoProtocols
        imagePickerController.configuration = config
        imagePickerController.imageLimit = 5
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func updatePhotoCollectionView()
    {
        
        let thumbnailImages = createPostPhotoProtocols.thumbnailImages.flatMap({ (slideShowImage) -> UIImage in
            slideShowImage.image
        })

        createPostPresenter.updateThumbnailImages(thumbnailImages)
        addPhotoCollectionView.reloadData()
    }
    
    func didTouchPhoto(onIndex index: Int)
    {
        
        ImageSlideShowViewController.presentFrom(self){ [weak self] controller in
            controller.dismissOnPanGesture = true
            controller.slides = self?.createPostPhotoProtocols.thumbnailImages
            controller.enableZoom = true
            controller.initialIndex = index - 1
            controller.controllerDidDismiss = {
                debugPrint("Controller Dismissed")
            }
        }
    }
    
}
