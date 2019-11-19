//
//  Login_ViewController.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 07/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class Login_ViewController:UIViewController{
   
    
    var phoneNumber:String?
    var verificationID:String?
    let helper:Login_helper = Login_helper()
    var loadingView:LoadingView?
    var timeCodeSent = 120
    fileprivate lazy var logo:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "logo_new"))
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    fileprivate lazy var background:UIImageView = {
        
        let im = UIImageView(image: #imageLiteral(resourceName: "loginBackground"))
        //im.image = UIImage(cgImage: #imageLiteral(resourceName: "backgroundMenu").cgImage!, scale: 1.0, orientation: UIImage.Orientation.leftMirrored)
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    
    fileprivate lazy var numberField:UITextField = {
        let f = UITextField()
        f.translatesAutoresizingMaskIntoConstraints = false
        f.keyboardType = .phonePad
        f.font = Theme.mainMenuFont
        f.textColor = .white
        f.backgroundColor = Theme.mainColor
        f.borderStyle = .roundedRect
        f.placeholder = "+92"
        return f
    }()
    
    fileprivate lazy var numberText:UILabel = {
        let f = UILabel()
        f.translatesAutoresizingMaskIntoConstraints = false
        f.font = Theme.mainMenuFont
        f.textColor = Theme.mainColor
        f.text = "Enter your phone number"
        return f
    }()
    
    fileprivate var loginButton:UIView = {
         let u = UIView()
         u.translatesAutoresizingMaskIntoConstraints = false
        u.backgroundColor = .black
         
         let l = UILabel()
         l.text = "Next"
         l.font = Theme.mainMenuFont
         l.textColor = .white
         l.translatesAutoresizingMaskIntoConstraints = false
         u.addSubview(l)
         l.centerYAnchor.constraint(equalTo: u.centerYAnchor).isActive = true
         l.centerXAnchor.constraint(equalTo: u.centerXAnchor).isActive = true
         
        
        u.layer.cornerRadius = 5
        u.layer.masksToBounds = true
         return u
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Theme.mainColor
        self.hideWeirdAssNavigationShadow()
        self.hideKeyboardWhenTappedAround()
        //numberField.isFirstResponder
        
        view.addSubview(background)
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        view.addSubview(logo)
        
        logo.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        logo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(numberText)
        numberText.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15).isActive = true
        numberText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        view.addSubview(numberField)
        numberField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        numberField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        numberField.topAnchor.constraint(equalTo: numberText.bottomAnchor, constant: 15).isActive = true
        numberField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 15).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
       loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))

    }
    
    func showLoading(){
        if loadingView == nil{
    loadingView = LoadingView.showLoading(view:view)
        }
        
    }
    func hideLoading(){
        if loadingView !=  nil{
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
        
    }
    
    fileprivate func showError(message:String = "Default"){}
    
    fileprivate func launchVerificationScreen(){
        hideLoading()
        print("success")
        
        let vc = VerificationController()
        vc.phoneNumber = phoneNumber!
        vc.verificationID = verificationID
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func sendVerificationCode(_ p_number:String){
        showLoading()
        
        phoneNumber = p_number
        helper.sendVerificationCode(number: phoneNumber!) {[weak self] (result) in
            switch result{
            case  let .success(vid):self?.verificationID = vid;self?.hideLoading();//self?.begin_timer()
            self?.launchVerificationScreen()
            case let .failure(error):print(error); self?.phoneNumber = nil;self?.hideLoading();self?.showError()
            }
            
        }
    }
    
    @objc fileprivate func login(){
        print("Called")
        showLoading()
        guard let phoneNumber = numberField.text else{
            hideLoading()
            showError()
            return
        }
        if phoneNumber != ""{
            sendVerificationCode(phoneNumber)

        }

        
    }
//    func begin_timer(){
//           Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
//            guard let self = self else{return}
//            if self.timeCodeSent != 0 {
//                self.timeCodeSent = self.timeCodeSent -  1
//            }else{
//
//            }
//
//
//
//        }
//
//           }
//
}
