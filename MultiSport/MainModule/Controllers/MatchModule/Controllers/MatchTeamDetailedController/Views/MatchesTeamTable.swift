//
//  MatchesTeamTable.swift
//  MultiSport
//
//  Created by Витя Рябко on 19/04/23.
//

import UIKit

protocol StatisticMatchProtocol: AnyObject {
    func presentStatistic(idFixture: Int)
}

protocol ChangeConstrainProtocol: AnyObject {
    func changeContstraints(width: CGFloat, height: CGFloat)
}

class MatchesTeamTable: UITableView {

    
    weak var statisticMatchDelegate: StatisticMatchProtocol?
    weak var changeConstrainDelegate: ChangeConstrainProtocol?
    
    private var modelFixtures = [PastFixturesByTeamID]()
    
    // id вибраного матча
    private var idFixture: Int = -1
    
    /* это multiplier который мы меняем при скролле в changeContstraints в протоколе - ChangeConstrainProtocol */
    let logoMainTeamInitialWidth: CGFloat = 0.35
    let logoMainTeamMinimumWidth: CGFloat = 0.15
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(MatchesTeamTableCell.self, forCellReuseIdentifier: MatchesTeamTableCell.identifier)
        
        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.showsVerticalScrollIndicator = false
    }
    
    // MARK: - setDelegate
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }
    
    // MARK: - setData
    public func setData(model: [PastFixturesByTeamID]) {
        self.modelFixtures = model
    }
    
    //  при нажатия на кнопку будет передаваться idFixture которой я присвоил когда размещались ячейки
    @objc private func didTapStatistiscButton(sender: UIButton) {
        statisticMatchDelegate?.presentStatistic(idFixture: sender.tag)

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MatchesTeamTable: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        modelFixtures.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerMatchSectionView = HeaderMatchSectionView()
        
        headerMatchSectionView.setData(model: modelFixtures[section])
        
        headerMatchSectionView.sectionIndex = section
        headerMatchSectionView.headerTapDelegate = self
        return headerMatchSectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchesTeamTableCell.identifier, for: indexPath) as? MatchesTeamTableCell else {
            return UITableViewCell()
        }
        
        cell.setData(model: modelFixtures[indexPath.section])
        
        cell.statisticButton.addTarget(self, action: #selector(didTapStatistiscButton), for: .touchUpInside)
        cell.statisticButton.tag = modelFixtures[indexPath.section].fixtureId
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /* меняю multiplier логотиапа команды при скролле */
        let yOffset = scrollView.contentOffset.y
        var width = logoMainTeamInitialWidth - (yOffset / 500)
        var height = logoMainTeamInitialWidth - (yOffset / 500)

        if width < logoMainTeamMinimumWidth {
            width = logoMainTeamMinimumWidth
        }

        if height < logoMainTeamMinimumWidth {
            height = logoMainTeamMinimumWidth
        }
        
        
        changeConstrainDelegate?.changeContstraints(width: width, height: height)
    }
}

extension MatchesTeamTable : HeaderTapProtocol {
    func hideContentSection(index: Int) {
        // TODO: - слелать colapseСontent в секции
    }
}
