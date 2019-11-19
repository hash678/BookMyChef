//
//  MenuCells.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 14/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit


class MainMenuNames:MenuCellBaseClass{
    

    var nameString:String?
    fileprivate lazy var name:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.mainMenuFont
        l.textColor = .white
        l.text = "Starters"
        l.textAlignment = .center
        return l
    }()
    
    override func setupCell(menu:MainMenu){
        name.text = menu.name
        nameString = menu.name
        
    }
    
    func selectCell(){
        name.textColor = Theme.mainColor
        self.backgroundColor = .white
    }
    func deselectCell(){
         name.font = Theme.mainMenuFont
        
        name.textColor = .white
        self.backgroundColor = Theme.mainColor
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews(){
        self.backgroundColor = .clear
        self.addSubview(name)
        name.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        name.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}


class MenuCell:MenuCellBaseClass, UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MenuItemCell
        cell.itemName.text = dataSource[indexPath.row].itemName
        cell.itemTime.text = "\(dataSource[indexPath.row].prepTime) mins"
        return cell
    }
    
    
    fileprivate var dataSource = [Menu]()
    fileprivate let cellIdentifier = "tableCell"
    var itemWidth:CGFloat = 80
    
    
    fileprivate lazy var tableView:UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = UIColor.clear
        t.delegate = self
        t.separatorStyle = .none
        t.dataSource = self
        t.indicatorStyle = .white
        t.register(MenuItemCell.self, forCellReuseIdentifier: cellIdentifier)
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func setupCell(menu:MainMenu){
        dataSource.removeAll()
        dataSource.append(contentsOf: menu.items)
        tableView.reloadData()
    }
    
    
    fileprivate func setupViews(){
        self.addSubview(tableView)
        self.backgroundColor = .clear
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


///TABLEVIEW CELL SUBLIST
class MenuItemCell:UITableViewCell {
    
    
   
    
    fileprivate lazy var itemName:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.meinMenuItemFont
        l.textColor = .white
        return l
        
    }()
    
    fileprivate lazy var itemTime:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.meinMenuItemFont
        l.textColor = .white
        l.textAlignment = .right
        return l
        
    }()
    
    
    fileprivate func setupViews(){
        self.selectionStyle = .none
        self.addSubview(itemTime)
        self.backgroundColor = .clear
        itemTime.rightAnchor.constraint(equalTo: self.rightAnchor,constant:0).isActive = true
        itemTime.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        itemTime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        self.addSubview(itemName)
        itemName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8).isActive = true
        itemName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        itemName.rightAnchor.constraint(equalTo: itemTime.rightAnchor, constant: -8).isActive = true
        
        
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

public class MenuCellBaseClass:UICollectionViewCell{
    func setupCell(menu:MainMenu){}
    
    
}

