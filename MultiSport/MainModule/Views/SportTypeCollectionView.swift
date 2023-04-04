//
//  SportTypeCollectionView.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

class SportTypeCollectionView: UICollectionView {
    
    // MARK: Layout
    private let layoutST = UICollectionViewFlowLayout()
    
    private let sportTypes = SportType.allCases
    
    // MARK: - Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layoutST)
        
        register(SportTypeCollectionViewCell.self, forCellWithReuseIdentifier: SportTypeCollectionViewCell.identifier)
        
        setDelegate()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Config
    private func config() {
        self.backgroundColor = .none
        layoutST.scrollDirection = .horizontal
        layoutST.minimumLineSpacing = 0
        self.bounces = false
    }
    
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SportTypeCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / CGFloat(sportTypes.count), height: collectionView.frame.height)
    }
}


// MARK: - UICollectionViewDataSource
extension SportTypeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sportTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportTypeCollectionViewCell.identifier, for: indexPath) as? SportTypeCollectionViewCell else {
            return UICollectionViewCell()
        }

        let image = sportTypes[indexPath.row].image
        cell.setIcon(image: image)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SportTypeCollectionView: UICollectionViewDelegate {
    
}



