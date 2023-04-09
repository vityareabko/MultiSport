//
//  MatchesTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 06/04/23.
//

import UIKit

class MatchesTableView: UITableView {
    
    // MARK: - Variables
    private var sectionsTableView = [SportDescriptionSection]()
    let sectionHeight: CGFloat = 50.0
    var isSectionHeaderStuck: Bool = false
    
    // MARK: - init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.identifier)
        
        config()
        setDelegate()
        sortTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Config
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.separatorStyle = .none
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    // MARK: Functions
    private func sortTableView() {
        let data = SportDescription.createData()
        let allLeagues = SportDescriptionTitle.allCases
        self.sectionsTableView = [SportDescriptionSection]()
        
        allLeagues.forEach { league in
            let itemsLegue = data.filter { item in
                item.title == league
            }
            if !itemsLegue.isEmpty{
                let section = SportDescriptionSection(title: league, items: itemsLegue)
                self.sectionsTableView.append(section)
            }
        }
    }
    
    // MARK: - Selectors
    
    
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MatchesTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsTableView.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        sectionHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SeactionMatchTableView()
        view.setLabel(textLabel: sectionsTableView[section].title.rawValue)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsTableView[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as? MatchTableViewCell else {
            return UITableViewCell()
        }
        let model = sectionsTableView[indexPath.section].items[indexPath.row]
        cell.setData(model: model)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topSectionIndex = self.indexPathsForVisibleRows?.first?.section ?? 0
        
        if topSectionIndex == 0 && self.contentOffset.y >= sectionHeight*2 {
            // нужно зафиксировать секцию 
            
        }
    }
    
    
}
