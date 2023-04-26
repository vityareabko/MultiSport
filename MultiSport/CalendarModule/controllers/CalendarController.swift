//
//  CalendarController.swift
//  MultiSport
//
//  Created by Витя Рябко on 26/04/23.
//

import UIKit

class CalendarController: UIViewController {
    
    // MARK: - Variables
    private var calendarDate = Date()
    
    // MARK: - UI Components
    private let calendarCollection = CalendarCollectionView()
    private let eventByDateTableView = EventByDateTableView()
    
    private let titleLabelController = UILabel(text: "Calendar", textColor: .specialOrangeColor, font: .gothamBold22())
    private let calendarButtonleft = UIButton(icon: UIImage(systemName: "chevron.backward")!)
    private let calendarButtonRight = UIButton(icon: UIImage(systemName: "chevron.right")!)
    private let calendarLabelDate = UILabel(text: "", textColor: .systemGray5, font: .gothamBold14())

    private let weekDay1 = UILabel(text: "MON", textColor: .specialLight, font: .gothamRegular12())
    private let weekDay2 = UILabel(text: "TUE", textColor: .specialLight, font: .gothamRegular12())
    private let weekDay3 = UILabel(text: "WED", textColor: .specialLight, font: .gothamRegular12())
    private let weekDay4 = UILabel(text: "THU", textColor: .specialLight, font: .gothamRegular12())
    private let weekDay5 = UILabel(text: "FRI", textColor: .specialLight, font: .gothamRegular12())
    private let weekDay6 = UILabel(text: "SAT", textColor: .specialLight, font: .gothamRegular12())
    private let weekDay7 = UILabel(text: "SUN", textColor: .specialLight, font: .gothamRegular12())
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .specialOrangeColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stackViewCalendarControll = UIStackView()
    
    private var stackViewWeek = UIStackView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
        setNavigationBar()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        setStackView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        self.calendarLabelDate.text = "\(dateFormatter.string(from: calendarDate))"
        
        calendarLabelDate.textAlignment = .center
        calendarLabelDate.text = calendarLabelDate.text?.uppercased()
        calendarButtonleft.tintColor = .systemGray5
        calendarButtonRight.tintColor = .systemGray5
        calendarButtonleft.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        calendarButtonRight.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        calendarButtonleft.tag = 0
        calendarButtonRight.tag = 1 
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(stackViewCalendarControll)
        self.view.addSubview(line)
        self.view.addSubview(stackViewWeek)
        self.view.addSubview(calendarCollection)
        self.view.addSubview(eventByDateTableView)
        
        calendarCollection.translatesAutoresizingMaskIntoConstraints = false
        eventByDateTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setStackView() {
        stackViewCalendarControll = UIStackView(arrangedSubviews: [calendarButtonleft, calendarLabelDate, calendarButtonRight])
        stackViewCalendarControll.axis = .horizontal
        stackViewCalendarControll.spacing = 10
        stackViewCalendarControll.distribution = .fill
        stackViewCalendarControll.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewWeek = UIStackView(arrangedSubviews: [weekDay1,weekDay2,weekDay3,
                                                       weekDay4,weekDay5,weekDay6,
                                                       weekDay7])
        
        stackViewWeek.axis = .horizontal
        stackViewWeek.spacing = 20
        stackViewWeek.distribution = .fillEqually
        stackViewWeek.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    // MARK: - Selectors
    @objc private func didTapButton(sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        var offsetDate: Date = self.calendarDate
        switch sender.tag{
        case 0:
            offsetDate = self.calendarDate.offsetMonth(month: -1)
        case 1:
            offsetDate = self.calendarDate.offsetMonth(month: 1)
        default:
            break
        }

        self.calendarDate = offsetDate
        calendarCollection.setDate(date: offsetDate)
        calendarCollection.reloadData()
        self.calendarLabelDate.text = "\(dateFormatter.string(from: calendarDate).uppercased())"
    }
}

// MARK: - Constraints
extension CalendarController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            stackViewCalendarControll.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 40),
            stackViewCalendarControll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackViewCalendarControll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            stackViewCalendarControll.heightAnchor.constraint(equalToConstant: 20),
            
            calendarButtonleft.widthAnchor.constraint(equalToConstant: 15),
            calendarButtonRight.widthAnchor.constraint(equalToConstant: 15),
            
            line.topAnchor.constraint(equalTo: stackViewCalendarControll.bottomAnchor, constant: 20),
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            line.heightAnchor.constraint(equalToConstant: 2),
            
            stackViewWeek.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 20),
            stackViewWeek.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackViewWeek.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            stackViewWeek.heightAnchor.constraint(equalToConstant: 20),
            
            calendarCollection.topAnchor.constraint(equalTo: stackViewWeek.bottomAnchor, constant: 20),
            calendarCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            calendarCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            calendarCollection.heightAnchor.constraint(equalToConstant: 280),
            
            eventByDateTableView.topAnchor.constraint(equalTo: calendarCollection.bottomAnchor, constant: 20),
            eventByDateTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            eventByDateTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            eventByDateTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
