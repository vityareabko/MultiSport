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
    private var data = [PastFixturesByTeamID]()
    
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
        self.modelFixtures[0].isExpandable = true
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
        80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerMatchSectionView = HeaderMatchSectionView()
        
        headerMatchSectionView.setData(model: modelFixtures[section])
        
        headerMatchSectionView.sectionIndex = section
        headerMatchSectionView.headerTapDelegate = self
        return headerMatchSectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.modelFixtures[indexPath.section].isExpandable {
            return 280
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.modelFixtures[section].isExpandable {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchesTeamTableCell.identifier, for: indexPath) as? MatchesTeamTableCell else {
            return UITableViewCell()
        }
        
        cell.setData(model: modelFixtures[indexPath.section])
        cell.clipsToBounds = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension MatchesTeamTable : HeaderTapProtocol {
    // TODO: - при скрытия ячейки скролл выбрасывает в самый верх
    func showContentSection(index: Int) {
        self.modelFixtures[index].isExpandable = !self.modelFixtures[index].isExpandable
        self.reloadSections([index], with: .fade)
    }
}
