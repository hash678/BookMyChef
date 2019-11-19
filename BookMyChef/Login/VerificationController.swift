//
//  VerificationController.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 19/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class VerificationController:UIViewController {
    
    var phoneNumber:String!
    var verificationID:String!
    var loadingView:LoadingView?
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
         f.placeholder = "Code"
         return f
     }()
     
     fileprivate lazy var numberText:UILabel = {
         let f = UILabel()
         f.translatesAutoresizingMaskIntoConstraints = false
         f.font = Theme.mainMenuFont
         f.textColor = Theme.mainColor
         f.text = "Enter Verification Code"
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
    
    fileprivate lazy var logo:UIImageView = {
           let im = UIImageView(image: #imageLiteral(resourceName: "logo_new"))
           im.translatesAutoresizingMaskIntoConstraints = false
           im.contentMode = .scaleAspectFit
           return im
       }()
     
    
    fileprivate func setupViews(){
        self.title = "Verify Number"
              self.hideKeyboardWhenTappedAround()
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
              
             loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(verify_code)))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func openMainViewController(){
         let vc = ChefListViewController()
         //vc.modalPresentationStyle = .fullScreen
         let navController = UINavigationController(rootViewController: vc)
         navController.modalPresentationStyle = .fullScreen
         
         self.present(navController, animated: true, completion: nil)

     }
    @objc fileprivate func verify_code() {
         print("Hello")
           guard let code = numberField.text else{print("Error");return}
           
           showLoading()
           let credential = PhoneAuthProvider.provider().credential(
               withVerificationID: verificationID,
               verificationCode: code)
           
           Auth.auth().signIn(with: credential) { [weak self](authResult, error) in
            self?.hideLoading()
               if let error = error {
                print(error)
                self?.showError()
                    return
               }
            self?.openMainViewController()
               
               
           }
           
           
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
}
