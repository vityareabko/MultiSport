//
//  FavoriteController.swift
//  MultiSport
//
//  Created by Витя Рябко on 30/05/23.
//

import UIKit

class FavoriteController: UIViewController {
    
    // MARK: - UI Components
    private let favoritePastTableView = FavoritePastMatchesTableView()
    private let favoriteFutureTableView = FavoriteFutureMatchesTableView()
    private let titleLabelController = UILabel(text: "Factor", textColor: .specialOrangeColor, font: .gothamBold22())
    
    private lazy var segmentControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["UPCOMING", "COMPLETED"])
        sc.selectedSegmentIndex = 1
        sc.backgroundColor = .specialBagroubdSubviews
        sc.selectedSegmentTintColor = .specialOrangeColor
        sc.setTitleTextAttributes([.font: UIFont.gothamBold15()!, .foregroundColor: UIColor.systemGray5], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.specialMainBaground], for: .selected)
        sc.addTarget(self, action: #selector(didTappedSegment), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationBar()
        setConstraints()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        
        favoriteFutureTableView.isHidden = true
        
        self.view.addSubview(titleLabelController)
        self.view.addSubview(segmentControl)
        self.view.addSubview(favoritePastTableView)
        self.view.addSubview(favoriteFutureTableView)
        
        favoritePastTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteFutureTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Selectors
    @objc func didTappedSegment(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            favoritePastTableView.isHidden = true
            favoriteFutureTableView.isHidden = false
        } else {
            favoriteFutureTableView.isHidden = true
            favoritePastTableView.isHidden = false
        }
    }
}

// MARK: - Constraints
extension FavoriteController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            segmentControl.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            segmentControl.heightAnchor.constraint(equalToConstant: 50),
            
            favoritePastTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 30),
            favoritePastTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            favoritePastTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            favoritePastTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            favoriteFutureTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 30),
            favoriteFutureTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            favoriteFutureTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            favoriteFutureTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}
