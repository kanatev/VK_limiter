//
//  AllGroupsTableVC.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 03/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import UIKit

protocol ChildViewControllerDelegate: class {
    func getDataBack(groupToAdd : GroupStruct) -> ()
}

class AllGroupsTableVC: UITableViewController {
    
    weak var delegate : ChildViewControllerDelegate?

    let allGroupsArray = GroupStruct.createAddGroupsArray()
    var groupToAdd: GroupStruct?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрируем кастомную XIB'ную ячейку
        let xibCellNib = UINib(nibName: "XibCell", bundle: nil)
        self.tableView.register(xibCellNib, forCellReuseIdentifier: "XibCell")
        //        self.tableView.register(, forHeaderFooterViewReuseIdentifier: )
        
        // задаем высоту ячейки
        self.tableView.rowHeight = 80
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCell", for: indexPath) as? XibCell else {preconditionFailure("XibCell doesn't work")}
        
        cell.ourLabel?.text = allGroupsArray[indexPath.row].groupName
        cell.shadowView.image1 = allGroupsArray[indexPath.row].groupAvatar ?? UIImage (named: "empty_photo")!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupToAdd = allGroupsArray[indexPath.row]
        self.delegate?.getDataBack(groupToAdd: groupToAdd!)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Groups"
    }
}
