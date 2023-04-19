//
//  MatchCollectionView.swift
//  MultiSport
//
//  Created by Витя Рябко on 09/04/23.
//

import UIKit

protocol TeamMatchDetailedProtocol: AnyObject {
    func selectTeamMatchesDetailed()
}

class MatchCollectionView: UICollectionView {
    
    private let layoutCollection = UICollectionViewFlowLayout()
    private let teams = TeamModel.createData()
    
    weak var selectItemDelegate: TeamMatchDetailedProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layoutCollection)
        register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: MatchCollectionViewCell.identifier)
        config()
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
        
        layoutCollection.minimumLineSpacing = 30
        layoutCollection.scrollDirection = .vertical
    }
}

extension MatchCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.frame.width / 2.2, height: self.frame.width / 2.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCollectionViewCell.identifier, for: indexPath) as? MatchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = teams[indexPath.row]
        cell.setData(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItemDelegate?.selectTeamMatchesDetailed()
    }
}

