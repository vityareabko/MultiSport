//
//  NotesController.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit

class NotesController: UIViewController {
    
    // MARK: - UI Components
    private var noticeTableView = NoticeTableView()
    
    private let titleLabelController = UILabel(text: "Notes", textColor: .specialOrangeColor, font: .gothamBold22())
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegate()
        setConstraints()
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Прокручиваем UITableView до верха
        noticeTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sortDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
        let allNotice = CoreDataManager.shared.fetchObjects(entity: Notice.self, sortDescriptors: [sortDescriptor])
        noticeTableView.setData(models: allNotice)
        noticeTableView.reloadData()
        
        
    }
  
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .specialMainBaground

        self.view.addSubview(titleLabelController)
        self.view.addSubview(noticeTableView)
        
        noticeTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // устанавливаю динамическую высоту для ячейки таблицы (использую другой способв в самой  self.noticeTableView)
        // self.noticeTableView.rowHeight = NoticeTableView.automaticDimension
    }
    
    private func setDelegate() {
        noticeTableView.noticeDelegate = self
        noticeTableView.noticeEditDelegate = self
    }
}

// MARK: - NoticeProtocol
extension NotesController: NoticeProtocol, NoticeEditProtocol{
    func editeNotice(index: Int) {
        let vc = CreateNoteController()
        let sortDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
        let allObjects = CoreDataManager.shared.fetchObjects(entity: Notice.self, sortDescriptors: [sortDescriptor])
        vc.editController = true
        vc.model = allObjects[index]
        vc.setData()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func createNotice() {
        let vc = CreateNoteController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - Extensions
extension NotesController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelController.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabelController.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabelController.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabelController.heightAnchor.constraint(equalToConstant: 25),
            
            noticeTableView.topAnchor.constraint(equalTo: titleLabelController.bottomAnchor, constant: 30),
            noticeTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            noticeTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            noticeTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
