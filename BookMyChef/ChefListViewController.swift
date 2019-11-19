//
//  ChefListViewController.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 18/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class ChefListViewController:UIViewController{
    
    fileprivate var dataSource = [Chef]()
    fileprivate let cellID = "id"
    fileprivate lazy var searchBar:UISearchBar = {
        let s = UISearchBar()
        s.searchBarStyle = .minimal
        s.barStyle = .black
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    fileprivate lazy var background:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "backgroundMenu"))
        im.image = UIImage(cgImage: #imageLiteral(resourceName: "backgroundMenu").cgImage!, scale: 1.0, orientation: UIImage.Orientation.upMirrored)
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFill
        return im
    }()
    fileprivate lazy var overly:UIView =  {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white.withAlphaComponent(0)
        return v
    }()
    
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(ChefCell.self, forCellWithReuseIdentifier: cellID)
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = .clear
        c.showsHorizontalScrollIndicator = false
        c.showsVerticalScrollIndicator = false
        return c
    }()
    
    
    fileprivate func setupViews(){
        navigationController?.navigationBar.tintColor = Theme.mainColor
        self.hideKeyboardWhenTappedAround()
        self.title = "Book Your Chef"
        view.backgroundColor = .white
        self.hideWeirdAssNavigationShadow()
        view.addSubview(background)
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        view.addSubview(overly)
        
        overly.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overly.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        overly.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        overly.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        
        view.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 15).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -15).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15).isActive = true
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        createFakeChefs()
    }
    
    
    
    
    fileprivate func createFakeChefs(){
        let names = ["Hassan Khan","Ajmal Durrani","Shahmir Khan", "Suliman Zafar","James Charles"]
        let cuisines = ["Chinese","South Asian","Thai"]
        for i in names{
            let chef = Chef(name: i, days: ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"], timing: "12:30pm - 8:30pm", picture: #imageLiteral(resourceName: "sampleChef"), menu: createFakeMenu(), rate: "Rs \(Int.random(in: 1000...5000))/hr", cuisines: cuisines)
            dataSource.append(chef)
        }
        
        collectionView.reloadData()
    }
    
    
    fileprivate func createFakeMenu() -> [MainMenu]{
        var returnSource = [MainMenu]()
        let itemNames = ["Starters","Main Course","Desserts","Beverages"]
        
        
        
        
        var menu1 = [Menu]()
        for _ in 0...30{
            menu1.append(Menu(itemName: "Soup", itemID: "soup123", prepTime: "30"))
        }
        let mainMenu1 = MainMenu(name: itemNames[0], items: menu1)
        returnSource.append(mainMenu1)
        
        var menu2 = [Menu]()
        for _ in 0...30{
            menu2.append(Menu(itemName: "Chawaal", itemID: "Chawaal111", prepTime: "90"))
        }
        let mainMenu2 = MainMenu(name: itemNames[1], items: menu2)
        returnSource.append(mainMenu2)
        
        var menu3 = [Menu]()
        for _ in 0...30{
            menu3.append(Menu(itemName: "Cake", itemID: "Cake123", prepTime: "60"))
        }
        let mainMenu3 = MainMenu(name: itemNames[2], items: menu3)
        returnSource.append(mainMenu3)
        
        var menu4 = [Menu]()
        for _ in 0...30{
            menu4.append(Menu(itemName: "Lemonade", itemID: "Lemonade123", prepTime: "15"))
        }
        let mainMenu4 = MainMenu(name: itemNames[3], items: menu4)
        returnSource.append(mainMenu4)
        
        
        
        
        
        
        
        return returnSource
    }
    
    
    
}


extension ChefListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChefCell
        cell.setupCell(chef:dataSource[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 40, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChefViewController()
        vc.chef = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

class ChefCell:UICollectionViewCell{
    
    fileprivate lazy var background:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.layer.shadowColor = UIColor.black.cgColor
        //v.layer.shadowOpacity = 0.5
        //v.layer.shadowOffset = CGSize(width: 0, height: 3)
        v.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        v.layer.cornerRadius = 5
        return v
    }()
    
    fileprivate lazy var menuView:ChefMenuView = {
        let c = ChefMenuView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
        
    }()
    
    fileprivate func setupViews(){
        self.addSubview(background)

        self.addSubview(menuView)
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        menuView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        menuView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        menuView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        
        
        
    }
    
    func setupCell(chef:Chef){
        menuView.setInformation(chef: chef)
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    
}


struct Chef{
    var name:String
    var days:[String]
    var timing:String
    var picture:UIImage
    var menu:[MainMenu]
    var rate:String
    var cuisines:[String]
    
    
}
