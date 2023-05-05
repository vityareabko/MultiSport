//
//  NoticeTableView.swift
//  MultiSport
//
//  Created by Витя Рябко on 27/04/23.
//

import UIKit
protocol NoticeProtocol: AnyObject {
    func createNotice()
}

protocol NoticeEditProtocol: AnyObject {
    func editeNotice(index: Int)
}

class NoticeTableView: UITableView {
    
    weak var noticeDelegate: NoticeProtocol?
    weak var noticeEditDelegate: NoticeEditProtocol?
    private var allNotice = [Notice]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        register(NoticeTableViewLastCell.self, forCellReuseIdentifier: NoticeTableViewLastCell.identifier)

        config()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - config
    private func config() {
        self.backgroundColor = .clear
        self.bounces = false
        self.showsVerticalScrollIndicator = false
    }

    // MARK: - setDelegate
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
    
    public func setData(models: [Notice]) {
        self.allNotice = models
    }
    
    @objc private func didTappedAddNoteButton() {
        noticeDelegate?.createNotice()
    }
    @objc private func didTappedEditButton(sender: UIButton) {
        noticeEditDelegate?.editeNotice(index: sender.tag)
    }
    
    @objc private func didTappedDeleteButton(sender: UIButton) {
        let sortDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
        let allObjects = CoreDataManager.shared.fetchObjects(entity: Notice.self, sortDescriptors: [sortDescriptor])
        CoreDataManager.shared.deleteObject(allObjects[sender.tag])
        self.allNotice.remove(at: sender.tag)
        self.reloadData()
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension NoticeTableView: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 270 // задаем фиксированую высоту ячейки
//    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // используем автоматический расчет высоты 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.allNotice.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == self.allNotice.count{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewLastCell.identifier) as? NoticeTableViewLastCell else {
                return UITableViewCell()
            }
            cell.addNoteButton.addTarget(self, action: #selector(didTappedAddNoteButton), for: .touchUpInside)
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else {
                return UITableViewCell()
            }
            
            cell.binButton.addTarget(self, action: #selector(didTappedDeleteButton), for: .touchUpInside)
            cell.binButton.tag = indexPath.row
            
            cell.editButton.addTarget(self, action: #selector(didTappedEditButton), for: .touchUpInside)
            cell.editButton.tag = indexPath.row

            cell.idModel = indexPath.row
            cell.setData(model: self.allNotice[indexPath.row])
            

            return cell
        }  
    }
}
