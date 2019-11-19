//
//  ChefViewController.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 13/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class ChefViewController:UIViewController{
    
    var chef:Chef?
    fileprivate lazy var background:UIImageView = {
        let im = UIImageView()
        //im.image = #imageLiteral(resourceName: "backgroundMenu")
        im.image = UIImage(cgImage: #imageLiteral(resourceName: "backgroundMenu").cgImage!, scale: 1.0, orientation: UIImage.Orientation.upMirrored)
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFill
        return im
    }()
    fileprivate lazy var overly:UIView =  {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return v
    }()
    
    
    //TODO:Add a data source
    fileprivate var dataSource = [MainMenu]()
    fileprivate lazy var menu:MenuView = {
        let menu = MenuView()
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    fileprivate lazy var chefHeader:ChefMenuView = {
        let v = ChefMenuView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setInformation(chef: chef!)
        v.rateLabel.textColor = .black

        return v
    }()
    
    fileprivate var bookButton:UIView = {
        let u = UIView()
        u.translatesAutoresizingMaskIntoConstraints = false
        u.backgroundColor = Theme.mainColor
        
        let l = UILabel()
        l.text = "BOOK"
        l.font = Theme.mainMenuFont
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        
        u.addSubview(l)
        l.centerYAnchor.constraint(equalTo: u.centerYAnchor).isActive = true
        l.centerXAnchor.constraint(equalTo: u.centerXAnchor).isActive = true
        u.layer.cornerRadius = 5
        return u
    }()
    
    @objc fileprivate func BookChef(){
        print("Clicked")
        let vc = BookViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        //navigationController?.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = (chef?.menu)!
        menu.setDatasource(source: dataSource)
        setupView()
        
    }
    
    fileprivate func setupView(){
        self.hideWeirdAssNavigationShadow()
        view.backgroundColor = .white
        
        view.addSubview(background)
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        view.addSubview(chefHeader)
        chefHeader.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        chefHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        //chefHeader.bottomAnchor.constraint(equalTo: menu.topAnchor,constant: -15).isActive = true
        chefHeader.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        view.addSubview(overly)
        
        overly.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overly.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        overly.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        overly.topAnchor.constraint(equalTo: chefHeader.bottomAnchor, constant: 8).isActive = true
        
        
        
        
        view.addSubview(bookButton)
        bookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        bookButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        bookButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BookChef)))
        
        view.addSubview(menu)
        
        
        
        
        
        menu.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 15).isActive = true
        menu.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -15).isActive = true
        menu.bottomAnchor.constraint(equalTo: bookButton.topAnchor, constant: -8).isActive = true
        menu.topAnchor.constraint(equalTo: overly.topAnchor, constant: 8).isActive = true
        
        
        
        
        
    }
    
    
    
}









struct MainMenu{
    var name:String
    var items:[Menu]
    
}

struct Menu {
    var itemName:String
    var itemID:String
    var prepTime:String
}
