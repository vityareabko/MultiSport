//
//  VitctoryTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 31/05/23.
//

import UIKit

class VitctoryTableView : UITableView {
    
    
    // MARK: - init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(VitctoryTableViewCell.self, forCellReuseIdentifier: VitctoryTableViewCell.identifier)
        
        config()
        setDelegate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func config() {
        backgroundColor = .clear
        bounces = false
        showsVerticalScrollIndicator = false
    }
    
    // MARK: - setDelgate
    private func setDelegate() {
        delegate = self
        dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension VitctoryTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        165 + 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VitctoryTableViewCell.identifier, for: indexPath) as? VitctoryTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

