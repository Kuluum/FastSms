//
//  FastSMSTableViewController.swift
//  FastSms
//
//  Created by Kuluum on 12.11.2020.
//

import UIKit
import SnapKit

class FastSMSTableViewController: UITableViewController {

    var model: SmsListModel?
    
    let addButton = UIButton(type: .contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SmsCell.self, forCellReuseIdentifier: "SmsCell")
        
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = 70
        
        tableView.addSubview(addButton)
        addButton.snp.makeConstraints { (make) -> Void in
            make.bottom.right.equalTo(tableView.safeAreaLayoutGuide).inset(20)
        }
    }

    func config(with model:SmsListModel) {
        self.model = model
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

