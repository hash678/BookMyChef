//
//  ChefMenuView.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 18/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class ChefMenuView:UIView {
    
    
      
    fileprivate lazy var background:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.layer.shadowColor = UIColor.black.cgColor
        //v.layer.shadowOpacity = 0.5
        //v.layer.shadowOffset = CGSize(width: 0, height: 3)
        v.backgroundColor = UIColor.clear
        
        return v
    }()
    
    fileprivate lazy var nameLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.chefNameFont
        l.text = ""
        l.numberOfLines = -1
        l.textColor = Theme.mainColor
        l.textAlignment = .left
        return l
    }()
    
    fileprivate lazy var cuisineLabel:UILabel = {
         let l = UILabel()
         l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.chefCusFont
         l.text = ""
         l.numberOfLines = -1
        l.textColor = .black
         l.textAlignment = .left
         return l
     }()
    
    
    
    fileprivate lazy var daysAvailable:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.dayFont
        l.numberOfLines = -1
        l.textColor = Theme.mainColor
        l.textAlignment = .left
        return l
    }()
    
    fileprivate lazy var timeLabel:UILabel = {
           let l = UILabel()
           l.translatesAutoresizingMaskIntoConstraints = false
           l.font = Theme.dayFont
           l.numberOfLines = -1
           l.textColor = .black
           l.textAlignment = .left
           return l
       }()
    fileprivate lazy var picture:UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.layer.masksToBounds = true
        i.image = #imageLiteral(resourceName: "sampleChef")
        i.layer.cornerRadius = 25
        //i.layer.borderWidth = 2
        //  i.layer.borderColor = UIColor.black.cgColor
        return i
    }()
    
     lazy var rateLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.rateFont
        l.textColor = .black
        
    
        return l
        
    }()
    
    
    func setInformation(chef:Chef){
        nameLabel.text = chef.name
        rateLabel.text = chef.rate
        daysAvailable.text = Helper.convertDaysToString(days: chef.days)
        cuisineLabel.text = Helper.convertCusinesToString(cuisine: chef.cuisines)
        timeLabel.text = chef.timing
        
    }
    
    fileprivate func setupViews(){
        
        
        self.addSubview(background)
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        
        
        
        self.addSubview(picture)
        picture.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 15).isActive = true
        picture.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        picture.heightAnchor.constraint(equalToConstant: 50).isActive = true
        picture.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        self.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: picture.rightAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        stack.addArrangedSubview(cuisineLabel)
        
        stack.addArrangedSubview(daysAvailable)
        stack.addArrangedSubview(timeLabel)
        
        self.addSubview(stack)
        stack.leftAnchor.constraint(equalTo: picture.rightAnchor, constant: 8).isActive = true
        stack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 65).isActive = true
        //stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        //
        
        
        self.addSubview(rateLabel)
        rateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -8).isActive = true
        rateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
    }
    override init(frame: CGRect) {
         super.init(frame:frame)
         setupViews()
     }
     required init?(coder: NSCoder) {
         fatalError()
     }
     
     
}

