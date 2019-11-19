//
//  CalendarHelper.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 18/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation
import UIKit



class DateHeader: JTACMonthReusableView  {
    fileprivate lazy var monthTitle:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = Theme.monthFont
        l.backgroundColor = .clear
        
        return l
    }()
    
    fileprivate lazy var daysStack:UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.translatesAutoresizingMaskIntoConstraints = false
        let days = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        for day in days{
            let label = UILabel()
            label.text = day.uppercased()
            label.textColor = .black
            label.textAlignment = .center
            label.font = Theme.dayFont
            s.addArrangedSubview(label)
            label.backgroundColor = .clear
            
            //label.backgroundColor = .yellow
        }
        s.distribution = .equalSpacing
        //s.backgroundColor = .yellow
        return s
        
    }()
    
    fileprivate func setupView(){
        
        self.backgroundColor = .clear
        self.addSubview(monthTitle)
        monthTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        monthTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //monthTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(daysStack)
        daysStack.topAnchor.constraint(equalTo: monthTitle.bottomAnchor, constant: 8).isActive = true
        daysStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier:0.95).isActive = true
        daysStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        daysStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


class CalendarCell:JTACDayCell {
    
    lazy var background:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.backgroundColor = .white
        
        return v
    }()
    lazy var dateLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        return l
    }()
    
    fileprivate func setupViews(){
        self.backgroundColor = Theme.mainColor
        
        self.addSubview(background)
        background.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        background.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        
        
        (background).addSubview(dateLabel)
        
        
        dateLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        
        
        
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func daySelected(_ selected:Bool){
        if selected{
            background.backgroundColor = .white
              background.layer.cornerRadius = self.frame.width / 2
              background.layer.borderWidth = 2
              background.layer.borderColor = UIColor.white.cgColor
            dateLabel.textColor = Theme.mainColor
            
        }else{
            background.backgroundColor = Theme.mainColor
            dateLabel.textColor = .white

            background.layer.cornerRadius = 0
            background.layer.borderWidth = 0
        }
    }
    
}

extension BookViewController:JTACMonthViewDataSource,JTACMonthViewDelegate{
    
    func handleDayCell(state:CellState, indexPath:IndexPath, cell:CalendarCell) -> JTACDayCell{
        cell.dateLabel.text = state.text
        
        if UnavailableDates.contains(state.date)  || state.dateBelongsTo != .thisMonth{
            cell.background.alpha = 0.6
        }else{
            cell.background.backgroundColor = Theme.mainColor
            cell.background.alpha = 1

            
        }
    
        cell.daySelected(selectedDay == state.date)
               
        return cell
    }
    
    
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: cellI, for: indexPath) as! CalendarCell
        return handleDayCell(state:cellState, indexPath:indexPath, cell:cell)
        //return cell
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = Date()
        print(formatter.string(from: startDate))
        let endDate = Calendar.current.date(byAdding: .month, value: 4, to: startDate)
        return ConfigurationParameters(startDate: startDate, endDate: endDate ?? Date())
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "LLLL"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: headerMonthI, for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start).uppercased()
        
        return header
    }
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 60)
    }
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
       
        if cellState.dateBelongsTo != .thisMonth || UnavailableDates.contains(cellState.date){
            return 
        }
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: cellI, for: indexPath) as! CalendarCell
       
        cell.daySelected(true)
        
       let previousIndexPath = selectedDayIndexPath
        selectedDay = cellState.date
        selectedDayIndexPath = indexPath
        if previousIndexPath != nil{
            calendar.reloadItems(at: [indexPath,previousIndexPath!])
            
        }else{
             calendar.reloadItems(at: [indexPath])
        }
    }
}

