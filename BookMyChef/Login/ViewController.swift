//
//  ViewController.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 07/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {

    fileprivate lazy var background:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "backgroundSplash"))
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    fileprivate lazy var logo:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "logo_new"))
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //TODO:Check Authentication
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            self.openMainViewController()
            //self.openMainViewController()
        }
        
    }
    
    fileprivate func openMainViewController(){
        let vc = ChefListViewController()
        //vc.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        
        self.present(navController, animated: true, completion: nil)

    }
    
    
    fileprivate func openLoginController(){
        let vc = Login_ViewController()
        //vc.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        
        self.present(navController, animated: true, completion: nil)

    }
    fileprivate func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(background)
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        

        view.addSubview(logo)
        logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        logo.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true


    }
    
    
    

}

