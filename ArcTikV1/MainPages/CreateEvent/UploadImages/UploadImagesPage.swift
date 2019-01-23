//
//  UploadImagesPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/11/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit

import AWSS3

class UploadImagesPage: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UploadImagesAddCellDelegate, UploadImageCellProtocol{
    
    var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .darkText, font: .montserratSemiBold(fontSize: 20), textAlign: .left);
        titleLabel.text = "Upload Photos";
        return titleLabel;
    }()
    
    
    var descriptionLabel: NormalUILabel = {
        let descriptionLabel = NormalUILabel(textColor: .darkGray, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        descriptionLabel.text = "You can upload up to 5 photos to present your event visually.";
        descriptionLabel.numberOfLines = 2;
        return descriptionLabel;
    }()
    
    var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        backgroundView.layer.cornerRadius = 3;
        backgroundView.layer.borderColor = UIColor.darkText.cgColor;
        backgroundView.layer.borderWidth = 1;
        backgroundView.isUserInteractionEnabled = true;
        return backgroundView;
    }()
    
    var plusImageView: UIImageView = {
        let plusImageView = UIImageView(image: #imageLiteral(resourceName: "plus"));
        plusImageView.translatesAutoresizingMaskIntoConstraints = false;
        plusImageView.contentMode = .scaleAspectFill;
        return plusImageView;
    }()
    
    var imageSelector: UIImageView = {
        let imageSelector = UIImageView(image: #imageLiteral(resourceName: "image"));
        imageSelector.translatesAutoresizingMaskIntoConstraints = false;
        imageSelector.contentMode = .scaleAspectFill;
        return imageSelector;
    }()
    
    var imagesList: UploadImagesList = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal;
        layout.itemSize = CGSize(width: 200, height: 220);
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20
        
        let uploadImagesList = UploadImagesList(frame: .zero, collectionViewLayout: layout);
        return uploadImagesList;
    }()
    
    var nextButton: NormalUIButton = {
        let nextButton = NormalUIButton(type: .system);
        nextButton.setButtonProperties(backgroundColor: .appBlue, title: "Next", font: .montserratSemiBold(fontSize: 14), fontColor: .white);
        return nextButton;
    }()
    
    
    
    var imagePicker = UIImagePickerController();
    var imageToUpload: UIImage?;
    var fileName: NSURL?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        imagePicker.delegate = self
        setCurrentEventData();
        setupNavBar();
        setupTitleLabel();
        setupDescriptionLabel();
        setupBackgroundView();
        setupImageView();
        setupPlusImage();
        setupUploadImageList();
        setupNextButton();
    }
    
    fileprivate func setCurrentEventData(){
        currentEvent?.stepNumber = 8;
        let name = Notification.Name(rawValue: reloadCreateEventPage);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupTitleLabel(){
        self.view.addSubview(titleLabel);
        titleLabel.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 10, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupDescriptionLabel(){
        self.view.addSubview(descriptionLabel);
        descriptionLabel.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.titleLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 0, constantBottom: 0, width: 0, height: 50);
    }
    
    fileprivate func setupBackgroundView(){
        self.view.addSubview(backgroundView);
        backgroundView.anchor(left: self.titleLabel.leftAnchor, right: self.titleLabel.rightAnchor, top: self.descriptionLabel.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 0, height: 150);
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showImagePicker));
        backgroundView.addGestureRecognizer(gestureRecognizer);
    }
    
    
    fileprivate func setupPlusImage(){
        self.backgroundView.addSubview(plusImageView);
        plusImageView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor, constant: 25).isActive = true;
        plusImageView.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor, constant: 0).isActive = true;
        plusImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        plusImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupImageView(){
        self.backgroundView.addSubview(imageSelector);
        imageSelector.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor, constant: -25).isActive = true;
        imageSelector.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor, constant: 0).isActive = true;
        imageSelector.widthAnchor.constraint(equalToConstant: 40).isActive = true;
        imageSelector.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupUploadImageList(){
        self.view.addSubview(imagesList);
//        imagesList.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.descriptionLabel.bottomAnchor, bottom: self.view.bottomAnchor);
        imagesList.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.descriptionLabel.bottomAnchor, bottom: nil, constantLeft: 10, constantRight: -10, constantTop: 10, constantBottom: 0, width: 0, height: 170);
        imagesList.isHidden = true;
        imagesList.uploadImagesPage = self;
    }
    
    fileprivate func setupNextButton(){
        self.view.addSubview(nextButton);
        nextButton.anchor(left: nil, right: self.view.rightAnchor, top: self.backgroundView.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: -25, constantTop: 35, constantBottom: 0, width: 100, height: 40);
        nextButton.addTarget(self, action: #selector(self.handleNextButtonPressed), for: .touchUpInside);
    }
}

extension UploadImagesPage{
    @objc func handleClearPressed(){
        let alert = UIAlertController(title: "Exit", message: "Do you want to save your listing?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            //save
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (action) in
            //not save
            self.dismiss(animated: true, completion: nil);
            //            self.navigationController?.popToRootViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    @objc func handleNextButtonPressed(){
        
        currentEvent?.images = self.imagesList.images;

        let layout = UICollectionViewFlowLayout();
        let reviewPage = ReviewPage(collectionViewLayout: layout);
        self.navigationController?.pushViewController(reviewPage, animated: true);
        
//        let imageData = UIImagePNGRepresentation(self.imageToUpload!);
//
//        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
//                                                                identityPoolId:"us-west-2:e9c5dc3f-acac-4006-b512-af168e1e47a9")
//        let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
//        AWSServiceManager.default().defaultServiceConfiguration = configuration
//
//
//        let transferUtility = AWSS3TransferUtility.default();
//        transferUtility.uploadData(imageData!, bucket: "arctikimages", key: "EventImages/img.png", contentType: "image/png", expression: nil, completionHandler: nil).continueWith { (task) -> Any? in
//            if let _ = task.error{
//                print("error");
//            }
//
//            if let _ = task.result{
//                //do something
//                print("success");
//            }
//            return nil
//        }
    }
    
    @objc func showImagePicker(){
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = true;
        self.present(imagePicker, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageToUpload = image;
            self.imagesList.images.append(image);
            self.imagesList.reloadData();
            self.imagesList.isHidden = false;
        }
//        self.fileName = info[UIImagePickerControllerImageURL] as? NSURL
        dismiss(animated: true, completion: nil);
    }
}

extension UploadImagesPage{
    func handleAddTapped() {
        if(imagesList.images.count < 5){
            self.showImagePicker();
        }
    }
    
    func removeImageAt(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Remove Image", message: "Are you sure you want to remove this image?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            if(self.imagesList.images.count >= 5){
                //reload table
                self.imagesList.images.remove(at: indexPath.item);
                self.imagesList.reloadData();
            }else{
                self.imagesList.images.remove(at: indexPath.item);
                self.imagesList.deleteItems(at: [indexPath]);
            }
            
            if(self.imagesList.images.count == 0){
                self.imagesList.isHidden = true;
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    
}
