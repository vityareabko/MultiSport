//
//  FactorTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 20/05/23.
//

import UIKit

class FactorTableView : UITableView {
    
    // MARK: - Variables
    private var model: [SectionFactorModel] = SectionFactorModel.getSomeObjects()
    
    // MARK: - init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(FactorTableViewCell.self, forCellReuseIdentifier: FactorTableViewCell.identifier)
        register(FactorTableFirstCell.self, forCellReuseIdentifier: FactorTableFirstCell.identifier) // default first cell
        
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
        separatorStyle = .none
        
    }
    
    // MARK: - setDelgate
    private func setDelegate() {
        delegate = self
        dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FactorTableView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FactorTableViewSection()
        view.tapToggleSectionDelegate = self
        view.sectionID = section
        
        if section == 0 {
            view.isFlipped = true
        } else {
            view.isFlipped = false
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].sectionItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if model[indexPath.section].expandable {
            return 80
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard model[indexPath.section].expandable else { return UITableViewCell() }
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FactorTableFirstCell.identifier, for: indexPath) as? FactorTableFirstCell else {
                return UITableViewCell()
            }
            
            cell.clipsToBounds = true
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FactorTableViewCell.identifier, for: indexPath) as? FactorTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setData(model: model[indexPath.section].sectionItems[indexPath.row - 1])
            cell.clipsToBounds = true
            
            return cell
        }
    }
}

extension FactorTableView: TapToggleSectionProtocol {
    func showContent(index: Int) {
        model[index].expandable = !model[index].expandable
        self.reloadRows(at: [[index,2]], with: .none)
    }
}

