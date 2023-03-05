//
//  ViewController.swift
//  MultiSport
//
//  Created by Витя Рябко on 05/03/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Click Me", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didtap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground

        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    // MARK: - Selectors
    
    @objc private func didtap(){
        let vc = UpComingController()
        self.navigationController?.pushViewController(vc, animated: true)
    }   
}

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([

            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100),

        ])
    }
}


