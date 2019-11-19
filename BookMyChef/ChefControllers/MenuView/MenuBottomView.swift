//
//  MenuBottomView.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 16/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class MenuBottomView:UIView{
    
    var delegate:MenuViewProtocol?
    fileprivate var dataSource = [MainMenu]()
    fileprivate let cellIdentifier = "menuCell"
    fileprivate lazy var menu:UICollectionView = {
        
        let layout = PagingCollectionViewLayout()
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = UIColor.clear
        c.delegate = self
        c.dataSource = self
        c.register(MenuCell.self, forCellWithReuseIdentifier: cellIdentifier)
        c.indicatorStyle = .white
        
        c.showsHorizontalScrollIndicator = false
        c.showsVerticalScrollIndicator = false
        c.isPagingEnabled = true
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        return c
    }()
    
    

    
    func scrollToMenu(index:Int){
        menu.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func refreshList(){
        (menu.collectionViewLayout as! PagingCollectionViewLayout).itemSize = self.frame.size
        menu.reloadData()
        
    }
    func setDatasource(source:[MainMenu]){
        dataSource = source
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


extension MenuBottomView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MenuCellBaseClass!
        
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MenuCell
        print(dataSource[indexPath.row].items[0].itemName)
        cell.setupCell(menu: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let _ = scrollView as? UICollectionView {
         let pageWidth = scrollView.frame.size.width
         let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        print(page)
        delegate?.menuSelected(index: page)
        //tableView.scrollToRow(at: IndexPath(item: page, section: 0), at: .middle, animated: true)
      
        }}
    
}
//MARK: Visual Code
extension MenuBottomView{
  
    fileprivate func setupView(){
        let view = self
        
        
        view.addSubview(menu)
        
        menu.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menu.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menu.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
protocol MenuViewProtocol {
    func menuSelected(index:Int)
    func categorySelected(index:Int)
}

