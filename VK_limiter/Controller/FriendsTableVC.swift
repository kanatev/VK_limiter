//
//  FriendsTableVC.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 03/07/2019.
//  Copyright © 2019 Aleksei Kanatev. All rights reserved.
//
import UIKit

@IBDesignable class FriendsTableVC: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var ourSearchBar: UISearchBar!
    
//    override open var shouldAutorotate: Bool {
//        return false
//    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    var friendsArray = UserStruct.createFriendsArray()
    var firstCharacters = [Character]()
    var sortedFriendsDict: [Character:[UserStruct]] = [:]
    
    var friendsArrayAPI = [FriendStruct]()
    var firstCharactersAPI = [Character]()
    var sortedFriendsDictAPI: [Character:[FriendStruct]] = [:]
     
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendCollectionVC" {
            let friendDestination: FriendCollectionVC = segue.destination as! FriendCollectionVC
            let friendSource = segue.source as! FriendsTableVC
            
            
            if let indexPath = friendSource.tableView.indexPathForSelectedRow {
                let ourSec = firstCharacters[indexPath.section]
                var tmpArray: [UserStruct] = []
                for dicct in sortedFriendsDict {
                    if dicct.key == ourSec {
                        tmpArray.append(contentsOf: dicct.value)
                    }
                }
                friendDestination.ourPerson = tmpArray[indexPath.row]
            }
        }
    }
    
    // Оставлю для новостной ленты
    //--------------------------------------------------------------------
    // refresh control
    //    var myRefreshControl: UIRefreshControl {
    //        let refControl = UIRefreshControl()
    //        refControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    //        return refControl
    //    }
    
    // action для refresh control
    //    @objc private func refresh(sender: UIRefreshControl) {
    //        let str = "Новый друг номер: \(friendsArray.count)"
    //        friendsArray.append(str)
    //        self.tableView.reloadData()
    //        sender.endRefreshing()
    //    }
    //--------------------------------------------------------------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ourSearchBar.delegate = self
        self.friendsArrayAPI = FriendsDataSingleton.shared.friendsArray!
        // объединяем массивы в кортеж и присваиваем результат sort()
        (firstCharacters, sortedFriendsDict) = sort(friendsArray)
        (firstCharactersAPI, sortedFriendsDictAPI) = sortFriendsFromAPI(friendsArrayAPI)
         
        //        self.refreshControl = myRefreshControl
        self.modalPresentationStyle = .fullScreen
        //        self.navigationController?.modalPresentationStyle = .fullScreen
        
        // задаем высоту ячейки
        self.tableView.rowHeight = 80
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        return firstCharacters.count
        return firstCharactersAPI.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let character = firstCharacters[section]
//        let friendsCount = sortedFriendsDict[character]?.count
//        return friendsCount ?? 0
        let character = firstCharactersAPI[section]
        let friendsCount = sortedFriendsDictAPI[character]?.count
        return friendsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
//        let character = firstCharacters[indexPath.section]
//        if let friends = sortedFriendsDict[character]{
//            cell.friendNameLabel.text = friends[indexPath.row].name
//            cell.shadowView.image1 = friends[indexPath.row].avatar
//
//            return cell
//        }
        let character = firstCharactersAPI[indexPath.section]
        if let friends = sortedFriendsDictAPI[character]{
            cell.friendNameLabel.text = friends[indexPath.row].first_name + " " + friends[indexPath.row].last_name
            cell.shadowView.image1 = friends[indexPath.row].photo100
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let character = firstCharacters[section]
        let character = firstCharactersAPI[section]
        return String(character)
    }
    
    //        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //            tableView.dequeueReusableHeaderFooterView(withIdentifier: )
    //        }
    
    
    // Func for sorting friends
    private func sort(_ friends: [UserStruct]) -> (characters: [Character], sortedCharacters: [Character:[UserStruct]]) {
        
        var characters = [Character]()
        var sortedPeople = [Character: [UserStruct]]()
        
        friends.forEach { friend in
            guard let character = friend.name.first else { return }
            if var thisCharFriends = sortedPeople[character] {
                thisCharFriends.append(friend)
                sortedPeople[character] = thisCharFriends
            } else {
                sortedPeople[character] = [friend]
                characters.append(character)
            }
        }
        
        characters.sort()
        
        return (characters, sortedPeople)
    }

    private func sortFriendsFromAPI(_ friends: [FriendStruct]) -> (characters: [Character], sortedCharacters: [Character:[FriendStruct]]) {
        
        var characters = [Character]()
        var sortedPeople = [Character: [FriendStruct]]()
        
        friends.forEach { friend in
            guard let character = friend.first_name.first else { return }
            if var thisCharFriends = sortedPeople[character] {
                thisCharFriends.append(friend)
                sortedPeople[character] = thisCharFriends
            } else {
                sortedPeople[character] = [friend]
                characters.append(character)
            }
        }
        characters.sort()
        return (characters, sortedPeople)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        (firstCharacters, sortedFriendsDict) = sort(friendsArray)
        arrayFilterByName()
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.ourSearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.ourSearchBar.showsCancelButton = false
        self.ourSearchBar.text = ""
        (firstCharacters, sortedFriendsDict) = sort(friendsArray)
        tableView.reloadData()
        self.ourSearchBar.resignFirstResponder()
    }
    
    func arrayFilterByName(){
        if self.ourSearchBar.searchTextField.text != ""{
            var tmpFriendArray:[UserStruct] = []
            
            // перебираем массив словарей (секций друзей)
            for currentDict in self.sortedFriendsDict {
                let stringInput = self.ourSearchBar.searchTextField.text!.lowercased()
                
                // перебираем массив друзей в секции
                for person in currentDict.value {
                    var tmpInternalArray:[UserStruct] = []
                    if person.name.lowercased().contains(stringInput) {
                        tmpInternalArray.append(person)
                    }
                    if !tmpInternalArray.isEmpty {
                        tmpFriendArray.append(contentsOf: tmpInternalArray)
                    }
                }
            }
            (firstCharacters, sortedFriendsDict) = sort(tmpFriendArray)
        } else {
            (firstCharacters, sortedFriendsDict) = sort(friendsArray)
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        let arrWithSectionNames = firstCharacters.map { String($0) }
        let arrWithSectionNames = firstCharactersAPI.map { String($0) }
        var arrWithDots: [String] = []
        for index in arrWithSectionNames.indices {
            if index == 0 || index % 2 == 0 {
                arrWithDots.append(arrWithSectionNames[index])
            } else {
                arrWithDots.append("•")
            }
        }
        return arrWithDots
    }
}

//extension UINavigationController {
//  open override var shouldAutorotate: Bool {
//    return true
//  }
//    
//  open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//    return .portrait
//  }
//}
