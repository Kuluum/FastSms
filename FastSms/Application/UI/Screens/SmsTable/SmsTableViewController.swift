//
//  FastSMSTableViewController.swift
//  FastSms
//
//  Created by Kuluum on 12.11.2020.
//

import UIKit
import SnapKit


class SmsTableViewController: UITableViewController {

    let addButton = UIButton(type: .custom)
    
    var model: SmsListModel?
    
    var onAddSms: (()->Void)?
    var onDeleteSms: ((_ deleteIndex: Int)->Void)?
    var onSendClick: ((_ smsModel: SmsModel)->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SmsCell.self, forCellReuseIdentifier: "SmsCell")
        
        setupUI()
    }
    
    func setupUI() {
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 70
        
        tableView.addSubview(addButton)
        addButton.setBackgroundImage(UIImage(named: "add-icon"), for: .normal)
        addButton.snp.makeConstraints {
            $0.bottom.right.equalTo(tableView.safeAreaLayoutGuide).inset(20)
            $0.height.width.equalTo(40)
        }
        
        addButton.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
    }
    
    func config(with model:SmsListModel) {
        self.model = model
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.list.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SmsCell") as? SmsCell,
        let cellModel = model?.list[indexPath.row] {
            cell.config(with: cellModel)
            return cell
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "wrong cell"
        cell.backgroundColor = .red
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let smsModel = model?.list[indexPath.row] {
            onSendClick?(smsModel)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func btnPress() {
        onAddSms?()
    }

}

// Table editing
extension SmsTableViewController {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            onDeleteSms?(indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
