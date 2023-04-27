//
//  NoticeTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit

class NoticeTableView: UITableView {
    
    private let numberOfRows = 4
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        register(NoticeTableViewLastCell.self, forCellReuseIdentifier: NoticeTableViewLastCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - config
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.showsVerticalScrollIndicator = false
//        self.estimatedRowHeight = self.a
    }
    

    // MARK: - setDelegate
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
    
    
    
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension NoticeTableView: UITableViewDataSource, UITableViewDelegate {  
    // это фисированая высота ячейки - если ставлю ее то ничего не ломается и кнопка становится узабельной
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        170
//    }
    
//    // это динамическая высота ячейки - но я использую другой метод в NotesController - одной строчкой - self.noticeTableView.rowHeight = NoticeTableView.automaticDimension
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        170
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.numberOfRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == numberOfRows{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewLastCell.identifier) as? NoticeTableViewLastCell else {
                return UITableViewCell()
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else {
                return UITableViewCell()
            }
            
            if indexPath.row % 2 == 0 {
                cell.noteBody.text = "West Brom ruthlessly exposed the 70-place gap between themselves. West Brom ruthlessly exposed the 70-place gap between themselves. West Brom ruthlessly exposed the 70-place gap between themselves. West Brom ruthlessly exposed the 70-place gap between themselves. West Brom ruthlessly exposed the 70-place gap between themselves. West Brom ruthlessly exposed the 70-place gap between themselves. West Brom ruthlessly exposed the 70-place gap between themselves"
            }
            return cell
        }
        
        
    }
    
    
}
