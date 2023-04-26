//
//  CalendarCollectionView.swift
//  MultiSport
//
//  Created by Витя Рябко on 26/04/23.
//

import UIKit

class CalendarCollectionView : UICollectionView {
    
    private let layoutCallendar = UICollectionViewFlowLayout()
    private var calendarDate: Date = Date()
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    private var indexOfDayInWeek = 0
    private var countDaysInMonth = 0
    private var todayDate = 0
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layoutCallendar)
        
        register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        config()
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
 
        calculateCountOfDaysInMonth(date: Date())
        self.todayDate = calendar.dateComponents(in: .current, from: calendarDate).day ?? 0
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func config() {
        self.layoutCallendar.minimumLineSpacing = 10
        self.backgroundColor = .clear
        self.dataSource = self
        self.delegate = self
    }
    
    private func calculateCountOfDaysInMonth(date: Date) {
        self.calendarDate = date
        self.indexOfDayInWeek = calendarDate.getNumberOfDayOfWeek()
        
        if let range = calendar.range(of: .day, in: .month, for: date) {
            self.countDaysInMonth = range.count + indexOfDayInWeek + 1// кол-во дней в месяце
        }
        
        if self.indexOfDayInWeek >= 6 {
            self.indexOfDayInWeek -= 7
            self.countDaysInMonth -= 7
        }
    }
    
    public func setDate(date: Date) {
        calculateCountOfDaysInMonth(date: date)
    }
}


// MARK: -  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension CalendarCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.frame.width / 9.8, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.countDaysInMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
         
        dateFormatter.string(from: calendarDate)
        
        if dateFormatter.string(from: calendarDate) == dateFormatter.string(from: Date())
            && indexPath.row == todayDate + indexOfDayInWeek {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)
        }
        
        if indexPath.row > indexOfDayInWeek   {
            cell.label.text = "\(indexPath.row - indexOfDayInWeek)"
            
            if indexPath.row % 12 == 0 {
                cell.back.layer.borderWidth = 2
                cell.back.layer.borderColor = UIColor.specialOrangeColor.cgColor
            } else {
                cell.back.layer.borderWidth = 0
            }
            
        } else {
            cell.back.layer.borderWidth = 0
            cell.label.text = ""
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select collection item - ", indexPath)
    }
}
