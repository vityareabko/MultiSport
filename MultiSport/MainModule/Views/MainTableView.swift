//
//  MainTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

class MainTableView: UITableView {
    
    private let mainTableTypeItems = MainTablesTypeItem.allCases
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        register(MainTableViewLastCell.self, forCellReuseIdentifier: MainTableViewLastCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
    }
    
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
        
    }
}


// MARK: - UITableViewDataSource
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainTableTypeItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mainTableTypeItems.count == indexPath.row {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewLastCell.identifier) as? MainTableViewLastCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.closureScrollToUp = { () in
                tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
                return UITableViewCell()
            }
            cell.setCell(modelType: mainTableTypeItems[indexPath.row])
            return cell
        }
    }
    
    
    
}

extension MainTableView: UITableViewDelegate {

}


