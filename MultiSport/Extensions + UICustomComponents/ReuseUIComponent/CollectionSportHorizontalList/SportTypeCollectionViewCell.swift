//
//  SportTypeCollectionViewCell.swift
//  MultiSport
//
//  Created by Витя Рябко on 04/04/23.
//

import UIKit

class SportTypeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SportTypeCollectionViewCell"
    
    // MARK: - Ui Components
    private let icontSport: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Error")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemGray5
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.icontSport.tintColor = .specialOrangeColor
            } else {
                self.icontSport.tintColor = .systemGray5
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(icontSport)
    }
    
    // MARK: - Settings
    public func setIcon(image: UIImage?) {
        guard let image = image else { return }
        icontSport.image = image
    }
    
}

// MARK: - SportTypeCollectionViewCell
extension SportTypeCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            icontSport.topAnchor.constraint(equalTo: self.topAnchor),
            icontSport.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icontSport.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            icontSport.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
