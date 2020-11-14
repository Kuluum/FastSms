//
//  FastSMSTableViewController.swift
//  FastSms
//
//  Created by Kuluum on 12.11.2020.
//

import UIKit
import SnapKit


class SmsTableViewController: UITableViewController {

    var model: SmsListModel?
    var onAddSms: (()->Void)?
    var onsSendClick: ((_ smsModel: SmsModel)->Void)?
    
    let addButton = UIButton(type: .contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SmsCell.self, forCellReuseIdentifier: "SmsCell")
        
        setupUI()
    }
    
    func setupUI() {
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 70
        
        tableView.addSubview(addButton)
        addButton.snp.makeConstraints { (make) -> Void in
            make.bottom.right.equalTo(tableView.safeAreaLayoutGuide).inset(20)
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
            onsSendClick?(smsModel)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func btnPress() {
        onAddSms?()
    }

}

