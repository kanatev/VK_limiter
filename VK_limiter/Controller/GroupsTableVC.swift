//
//  GroupsTableVC.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 03/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//

import UIKit

class GroupsTableVC: UITableViewController, UISearchBarDelegate, ChildViewControllerDelegate {
        
    func getDataBack(groupToAdd: GroupStruct) {
        
        let newGroup = groupToAdd
        
        // проверяем нет ли уже такой группы
        guard !groupsArray.contains(where: {group -> Bool in
            group == newGroup
        }) else {return}
        groupsArray.append(newGroup)
        self.filteredArray = self.groupsArray
        tableView.reloadData()
    }
    
    var groupsArrayFromAPI: [GroupStructAPI] = []
    var groupsArrayFromAPIWithPhoto: [GroupStructAPIWithPhoto] = []

    
    var groupsArray = GroupStruct.createGroupsArray()
    var filteredArray:[GroupStruct]!
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var ourSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ourSearchBar.delegate = self
        self.filteredArray = self.groupsArray
        
        // регистрируем кастомную XIB'ную ячейку
        let xibCellNib = UINib(nibName: "XibCell", bundle: nil)
        self.tableView.register(xibCellNib, forCellReuseIdentifier: "XibCell")
        //        self.tableView.register(, forHeaderFooterViewReuseIdentifier: )
        
        // задаем высоту ячейки
        self.tableView.rowHeight = 80
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.groupsArrayFromAPI = GroupsDataSingleton.shared.groupsArray ?? []
        self.groupsArrayFromAPIWithPhoto = GrDatSingWithPhoto.shared.groupsArray ?? []
        
        tableView.reloadData()
    }
    
    //    добавление группы через обратный сегвей
    //    @IBAction func addGroup(segue: UIStoryboardSegue) {
    //        guard let addGroups = segue.source as? AllGroupsTableVC,
    //            let indexPath = addGroups.tableView.indexPathForSelectedRow else {return}
    //        let newGroup = addGroups.allGroupsArray[indexPath.row]
    //
    //        // проверяем нет ли уже такой группы
    //        guard !groupsArray.contains(where: {group -> Bool in
    //            group == newGroup
    //        }) else {return}
    //        groupsArray.append(newGroup)
    //        self.filteredArray = self.groupsArray
    //        tableView.reloadData()
    //    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.filteredArray.count
        return self.groupsArrayFromAPIWithPhoto.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "XibCell", for: indexPath) as? XibCell else {preconditionFailure("XibCell doesn't work")}
//        cell.ourLabel?.text = self.filteredArray[indexPath.row].groupName
//        cell.shadowView.image1 = self.filteredArray[indexPath.row].groupAvatar ?? UIImage(named: "empty_photo")!
        
//        cell.ourLabel?.text = self.groupsArrayFromAPI[indexPath.row].name
        cell.ourLabel?.text = self.groupsArrayFromAPIWithPhoto[indexPath.row].name

        
        //        cell.ourLabel?.text = GroupsDataSingleton.shared.groupsArray[indexPath.row].name
//        cell.ourLabel?.text = GroupsDataSingleton.shared.groupsArray

//        let ourUrl = URL(fileURLWithPath: self.groupsArrayFromAPI[indexPath.row].photo50)
//        let ourImage = downloadImage(from: ourUrl)
        
//        cell.shadowView.image1 = UIImage(named: "empty_photo")!
        cell.shadowView.image1 = self.groupsArrayFromAPIWithPhoto[indexPath.row].photo100 

        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //             Delete the row from the data source
            self.filteredArray.remove(at: indexPath.row)
            self.groupsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text ?? "nothing entered")
        arrayFilterByName()
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.ourSearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.ourSearchBar.showsCancelButton = false
        self.ourSearchBar.text = ""
        self.filteredArray = self.groupsArray
        tableView.reloadData()
        self.ourSearchBar.resignFirstResponder()
    }
    
    func getListOfNames() -> [String]{
        var tempArray:Array<String> = []
        for i in self.groupsArray {
            tempArray.append(i.groupName)
        }
        return tempArray
    }
    
    func arrayFilterByName(){
        if self.ourSearchBar.searchTextField.text != ""{
            var tmpArray = [GroupStruct]()
            for i in self.groupsArray {
                
                let stringInput = self.ourSearchBar.searchTextField.text!.lowercased()
                if i.groupName.lowercased().contains(stringInput) {
                    tmpArray.append(i)
                }
            }
            self.filteredArray = tmpArray
        } else {
            self.filteredArray = self.groupsArray
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToAllGroups"{
            let secondView = segue.destination as! AllGroupsTableVC
            secondView.delegate = self
            searchBarCancelButtonClicked(self.ourSearchBar)
        }
    }
}

// убираем постоянное выделение ячейки
extension GroupsTableVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
