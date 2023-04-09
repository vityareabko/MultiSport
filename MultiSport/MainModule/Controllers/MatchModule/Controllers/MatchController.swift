//
//  MatchController.swift
//  MultiSport
//
//  Created by Витя Рябко on 06/04/23.
//

import UIKit

class MatchController: UIViewController {
    
    // MARK: - Controllers
    private let childTableController = MatchesTableController()
    private let childCollectionController = MatchCollectionController()
    
    // MARK: - UI Components
    private lazy var segmentControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["UPCOMING", "COMPLETED"])
        sc.selectedSegmentIndex = 0
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
        setConstraints()
        
        setupSecondViewController(viewController: childTableController, view: segmentControl)
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground
        self.view.addSubview(segmentControl)
    }
    
    
    // MARK: - Selectors
    @objc private func didTappedSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            removeChildController(childController: childCollectionController)
            setupSecondViewController(viewController: childTableController, view: segmentControl)
        case 1:
            removeChildController(childController: childTableController)
            setupSecondViewController(viewController: childCollectionController, view: segmentControl)
        default:
            print("errorc")
        }
    }
}

extension MatchController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            segmentControl.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
}


