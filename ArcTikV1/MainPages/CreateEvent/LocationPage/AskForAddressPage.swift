//
//  AskForAddressPage.swift
//  ArcTikV1
//
//  Created by Brandon In on 1/17/19.
//  Copyright © 2019 Brandon In. All rights reserved.
//

import UIKit
import GooglePlaces

protocol AskForAddressPageDelegate{
    func setAddressData(address: String, zipcode: String, city: String, country: String);
}

class AskForAddressPage: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
    var addressTextField: NormalUITextField = {
        let addressTextField = NormalUITextField();
        addressTextField.translatesAutoresizingMaskIntoConstraints = false;
        addressTextField.autocorrectionType = .no;
        addressTextField.spellCheckingType = .no;
        addressTextField.font = UIFont.systemFont(ofSize: 14);
        addressTextField.placeholder = "Address";
        return addressTextField;
        
    }()
    
    var poweredByGoogleView: UIImageView = {
        let poweredByGoogleView = UIImageView(image: #imageLiteral(resourceName: "googleLogo"));//8:1 width to height ratio
        poweredByGoogleView.translatesAutoresizingMaskIntoConstraints = false;
        poweredByGoogleView.contentMode = .scaleAspectFill
        return poweredByGoogleView;
    }();
    
    var addressBorder = BorderView();
    let placesClient = GMSPlacesClient();
    var timer: Timer?;
    
    let addressCellReuse = "AddressCellReuse";
    
    var addressResults = [GMSAutocompletePrediction]();

    var cityResult: String?
    var zipcodeResult: String?
    var countryResult: String?;
    var addressPageDelegate: AskForAddressPageDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        collectionView?.contentInset = UIEdgeInsets(top: 65, left: 0, bottom: 0, right: 0);
        collectionView?.register(AddressResultCell.self, forCellWithReuseIdentifier: addressCellReuse);
        collectionView?.backgroundColor = UIColor.white;
        setupNavBar();
        setupAddressTextField();
        setupGoogleView();
        self.addressTextField.becomeFirstResponder();
    }
    
    fileprivate func setupNavBar(){
        let clearButton = UIBarButtonItem(image: UIImage(named: "clearWhiteNav"), style: .plain, target: self, action: #selector(self.handleClearPressed));
        self.navigationItem.leftBarButtonItem = clearButton;
    }
    
    fileprivate func setupAddressTextField(){
        self.view.addSubview(addressTextField);
        addressTextField.anchor(left: self.view.leftAnchor, right: self.view.rightAnchor, top: self.view.topAnchor, bottom: nil, constantLeft: 25, constantRight: -25, constantTop: 15, constantBottom: 0, width: 0, height: 30);
        addressTextField.delegate = self;
        addressTextField.addTarget(self, action: #selector(self.textFieldValueChanged), for: .editingChanged);
        
        self.view.addSubview(addressBorder);
        addressBorder.anchor(left: self.addressTextField.leftAnchor, right: self.addressTextField.rightAnchor, top: self.addressTextField.bottomAnchor, bottom: nil, constantLeft: 0, constantRight: 0, constantTop: 10, constantBottom: 0, width: 0, height: 0.4);
    }
    
    fileprivate func setupGoogleView(){
        self.view.addSubview(poweredByGoogleView);
        poweredByGoogleView.anchor(left: nil, right: self.view.rightAnchor, top: nil, bottom: nil, constantLeft: 0, constantRight: -10, constantTop: 0, constantBottom: 0, width: 160, height: 20);
//        if(UIScreenHeight == 736){
//            poweredByGoogleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60).isActive = true;
//        }
        poweredByGoogleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60).isActive = true;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addressCellReuse, for: indexPath) as! AddressResultCell;
        if(addressResults.count > 0){
            cell.setAddress(address: addressResults[indexPath.item].attributedFullText.string);
        }
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressResults.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.placesClient.lookUpPlaceID(addressResults[indexPath.item].placeID!, callback: { (place, err) in
            if let error = err{
                print(error);
            }
            if let place = place{
                for component in place.addressComponents!{
                    if(component.type == kGMSPlaceTypeLocality){//city
//                        self.cityResults.append(component.name);
                        self.cityResult = component.name;
                    }
                    
                    if(component.type == kGMSPlaceTypeAdministrativeAreaLevel1){// state
//                        self.stateResults.append(component.name)
                    }
                    
                    if(component.type == kGMSPlaceTypePostalCode){//zipcode
//                        self.zipcodeResults.append(component.name);
                        self.zipcodeResult = component.name;
                    }
                    
                    if(component.type == kGMSPlaceTypeCountry){
//                        self.countryResults.append(component.name);
                        self.countryResult = component.name;
                    }
                }
                
            }
            
            
            self.addressPageDelegate?.setAddressData(address: self.addressResults[indexPath.item].attributedPrimaryText.string, zipcode: self.zipcodeResult!, city: self.cityResult!, country: self.countryResult!);

            self.dismiss(animated: true, completion: nil);
        })
        
        
        
    }
    
    @objc func textFieldValueChanged(){
        self.addressResults.removeAll();
        timer?.invalidate();
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.handleSearchAddresses), userInfo: nil, repeats: false);
    }
    
}

extension AskForAddressPage{
    @objc func handleClearPressed(){
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc func handleSearchAddresses(){
//        print("search");
        if(self.addressTextField.text!.count > 0){
            let searchText = addressTextField.text!
            let filter = GMSAutocompleteFilter()
            filter.type = .noFilter;
            placesClient.autocompleteQuery(searchText, bounds: nil, filter: filter, callback: {(results, error) -> Void in
                if let error = error {
                    print("Autocomplete error \(error)")
                    return
                }
                if let results = results {
                    for result in results {
                        self.addressResults.append(result);
//                        self.placeIDs.append(result.placeID!);
                    }
                }
                self.collectionView?.reloadData();
            })
        }

    }
}

class AddressResultCell: UICollectionViewCell{
    
    var addressLabel: NormalUILabel = {
        let addressLabel = NormalUILabel(textColor: .darkText, font: .montserratMedium(fontSize: 14), textAlign: .left);
        addressLabel.text = "Address goes here";
        addressLabel.numberOfLines = 2;
        return addressLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupAddressLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupAddressLabel(){
        self.addSubview(addressLabel);
        addressLabel.anchor(left: self.leftAnchor, right: self.rightAnchor, top: self.topAnchor, bottom: self.bottomAnchor, constantLeft: 25, constantRight: -25, constantTop: 0, constantBottom: 0, width: 0, height: 0)
    }
    
    func setAddress(address: String){
        self.addressLabel.text = address;
    }
}
