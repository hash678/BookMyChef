//
//  MenuTopView.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 16/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class MenuTopView:UIView{
    
    fileprivate var selectedIndexPath:IndexPath?
    var delegate:MenuViewProtocol?
    fileprivate var selectedIndex:String?
    fileprivate let cellIdentifierV = "menuCellV"
    fileprivate var dataSource = [MainMenu]()
    fileprivate lazy var menuVList:UICollectionView = {
        
        
        
        let layout = UICollectionViewFlowLayout()
        
        
        
        
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = Theme.mainColor
        c.delegate = self
        c.dataSource = self
        c.register(MainMenuNames.self, forCellWithReuseIdentifier: cellIdentifierV)
        c.showsHorizontalScrollIndicator = false
        c.layer.cornerRadius = 5
        layout.scrollDirection = .horizontal
        
        return c
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    func selectCategory(index:Int){
        
        let indexPath = IndexPath(row: index, section: 0)
        let menu = dataSource[index]
        selectedIndex = menu.name
       
        let cell = menuVList.dequeueReusableCell(withReuseIdentifier: cellIdentifierV, for: indexPath) as! MainMenuNames
        cell.selectCell()
        menuVList.reloadData()
        menuVList.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    
    func refreshList(){
        
        menuVList.reloadData()
        
    }
    func setDatasource(source:[MainMenu]){
        dataSource = source
        if source.count > 0 {
            selectedIndex = source[0].name}
        refreshList()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
extension MenuTopView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierV, for: indexPath) as! MainMenuNames
        
        cell.setupCell(menu: dataSource[indexPath.row])
        
        if dataSource[indexPath.row].name == selectedIndex{
            print(dataSource[indexPath.row].name)
            cell.selectCell()
        
        }else{
            cell.deselectCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let height = collectionView.frame.height
        
        return  CGSize(width: getLargestSize(), height: height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = dataSource[indexPath.row]
        selectedIndex = menu.name
        delegate?.categorySelected(index: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierV, for: indexPath) as! MainMenuNames
        cell.selectCell()
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)

    }
}

//MARK: Visual Code
extension MenuTopView{
    fileprivate func setupView(){
        let view = self
        view.addSubview(menuVList)
        menuVList.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuVList.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuVList.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuVList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    fileprivate func getLargestSize() -> CGFloat{
        var large:CGFloat = -1
        for i in dataSource{
            
            let fontAttributes = [NSAttributedString.Key.font: Theme.mainMenuFont]
            let text = i.name
            let size = text.size(withAttributes: fontAttributes).width + 15
            large = (size > large) ? size: large
        }
        return large
        
    }
    
}
