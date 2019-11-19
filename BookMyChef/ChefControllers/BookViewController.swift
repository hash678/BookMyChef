//
//  BookViewController.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 16/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit

class BookViewController:UIViewController{
    //CALENDAR CODE
    var selectedDay:Date?
    var selectedDayIndexPath:IndexPath?
    var UnavailableDates = [Date]()
    let cellI = "dateCell"
    let headerMonthI = "headerMonth"
    
    
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
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate lazy var calendarView:JTACMonthView = {
        let c = JTACMonthView()
        c.minimumLineSpacing = 0
        c.minimumInteritemSpacing = 0
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(CalendarCell.self, forCellWithReuseIdentifier: cellI)
        c.register(DateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerMonthI)
        c.ibCalendarDelegate = self
        c.ibCalendarDataSource = self
        c.scrollDirection = .horizontal
        c.showsHorizontalScrollIndicator = false
        c.showsVerticalScrollIndicator = false
        c.layer.cornerRadius = 5
        c.layer.masksToBounds = true
        c.isPagingEnabled = true
        return c
    }()
    
    fileprivate func setupView(){
        self.navigationController?.navigationBar.tintColor = Theme.mainColor
        //navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Book Appointment"
        view.backgroundColor = .white
        
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
        
        view.backgroundColor = .white
        view.addSubview(calendarView)
        
        
        calendarView.backgroundColor = .clear
        calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15).isActive = true
        calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        calendarView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        
        
    }
    
}

