//
//  MenuView.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 15/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class MenuView:UIView{
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    fileprivate func refreshLists(){
        MenuTop.refreshList()
        MenuBottom.refreshList()
    }
    
    
    
    fileprivate var dataSource = [MainMenu]()
    
    fileprivate lazy var menuHeader:UIView = {
        let l = UIView()
        l.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let itemName = UILabel()
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemName.text = "ITEM"
        itemName.textColor = Theme.mainColor
        itemName.font = Theme.mainMenuFont
        itemName.textAlignment = .center
        
        l.addSubview(itemName)
        
        itemName.leftAnchor.constraint(equalTo: l.leftAnchor, constant: 15).isActive = true
        itemName.centerYAnchor.constraint(equalTo: l.centerYAnchor).isActive = true
        
        let itemName2 = UILabel()
        itemName2.translatesAutoresizingMaskIntoConstraints = false
        itemName2.text = "PREPERATION TIME"
        itemName2.textAlignment = .right
        itemName2.textColor = Theme.mainColor
        itemName2.font = Theme.mainMenuFont
        l.addSubview(itemName2)
        
        itemName2.rightAnchor.constraint(equalTo: l.rightAnchor, constant: -8).isActive = true
        itemName2.centerYAnchor.constraint(equalTo: l.centerYAnchor).isActive = true
        
        
        return l
    }()
    
    fileprivate lazy var MenuTop:MenuTopView = {
        
        
        
        let m = MenuTopView()
        m.delegate = self
        m.translatesAutoresizingMaskIntoConstraints = false
        return m
    }()
    
    
    fileprivate lazy var MenuBottom:MenuBottomView = {
        
        let m = MenuBottomView()
        m.delegate = self
        m.translatesAutoresizingMaskIntoConstraints = false
        return m
    }()
    
    
    
    fileprivate func setupView(){
        let view = self        
        
        
        
        view.addSubview(MenuTop)
        MenuTop.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        MenuTop.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        MenuTop.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        MenuTop.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(menuHeader)
        menuHeader.topAnchor.constraint(equalTo: MenuTop.bottomAnchor, constant: 8).isActive = true
        menuHeader.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        menuHeader.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.addSubview(MenuBottom)
        
        MenuBottom.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        MenuBottom.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        MenuBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        MenuBottom.topAnchor.constraint(equalTo: menuHeader.bottomAnchor, constant:8).isActive = true
    }
    
    
    func setDatasource(source:[MainMenu]){
        self.dataSource = source
        MenuBottom.setDatasource(source: source)
        MenuTop.setDatasource(source: source)
        refreshLists()
    }
    
    
    
}



extension MenuView:MenuViewProtocol{
    func menuSelected(index: Int) {
        print("INDEX: \(index)")
        MenuTop.selectCategory(index: index)
    }
    
    func categorySelected(index: Int) {
        MenuBottom.scrollToMenu(index:index)
    }
    
    
}
