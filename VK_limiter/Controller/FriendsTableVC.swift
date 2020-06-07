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
    
    var grayView: UIView?
    var dotsView: UIView?
    
    var animationPerformed = false
    var currentFriendPhotos: [CurrentFriendPhotoStruct] = []

    var friendsArray = UserStruct.createFriendsArray()
    var firstCharacters = [Character]()
    var sortedFriendsDict: [Character:[UserStruct]] = [:]
    
    var friendsArrayAPI = [FriendStruct]()
    var firstCharactersAPI = [Character]()
    var sortedFriendsDictAPI: [Character:[FriendStruct]] = [:]
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var friendId: Int?
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let ourSec = firstCharactersAPI[indexPath.section]
            var tmpArray: [FriendStruct] = []
            for dicct in sortedFriendsDictAPI {
                if dicct.key == ourSec {
                    tmpArray.append(contentsOf: dicct.value)
                }
            }
            friendId = tmpArray[indexPath.row].id
        }

        
        animation()
        photosGetAll(friendId: friendId!)
    }
    
    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendCollectionVC" {
            
            
            let friendDestination: FriendCollectionVC = segue.destination as! FriendCollectionVC
            let friendSource = segue.source as! FriendsTableVC
            
            
            if let indexPath = friendSource.tableView.indexPathForSelectedRow {
                //                let ourSec = firstCharacters[indexPath.section]
                let ourSec = firstCharactersAPI[indexPath.section]
                
                //                var tmpArray: [UserStruct] = []
                //                for dicct in sortedFriendsDict {
                //                    if dicct.key == ourSec {
                //                        tmpArray.append(contentsOf: dicct.value)
                //                    }
                //                }
                //                friendDestination.ourPerson = tmpArray[indexPath.row]
                var tmpArray: [FriendStruct] = []
                for dicct in sortedFriendsDictAPI {
                    if dicct.key == ourSec {
                        tmpArray.append(contentsOf: dicct.value)
                    }
                }
                friendDestination.ourPerson = tmpArray[indexPath.row]
//                animation()
                friendDestination.photoArray = CurrentFriendPhotoSingleton.shared.currentFriendPhoto!
                print(friendDestination.photoArray)
            }
        }
    }
    
    func photosGetAll(friendId: Int){
        
        var friendPhotoArray: [CurrentFriendPhotoStruct] = []
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "owner_id", value: String(friendId)),
            URLQueryItem(name: "extended", value: "0"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "v", value: "5.107")]
        
        guard let url = urlComponents.url else { preconditionFailure("bad URL")}
        var request2 = URLRequest(url: url)
        request2.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request2) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return }
            let friends = json as! [String: Any]
            let response = friends["response"] as! [String: Any]
            let items = response["items"] as! [Any]
            for item in items {
                let photo = item as! [String: Any]
                let id = photo["id"] as! Int
                let sizes = photo["sizes"] as! [Any]
                //                        for item in sizes {
                //                            let  size = item as! [String: Any]
                //                            let url = size["url"] as! String
                //                        }
                let ourSize = sizes.first as! [String:Any]
                let url = ourSize["url"] as! String
                
                
                // фетчим фото
                self.fetchImage(from: url, completionHandler: { (imageData) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            let img = UIImage(data: data)
                            let currentPhoto = CurrentFriendPhotoStruct(id: id, photo: img!)
                            friendPhotoArray.append(currentPhoto)
                            CurrentFriendPhotoSingleton.shared.currentFriendPhoto = friendPhotoArray
//                            print(friendPhotoArray)
                        }
                    } else {
                        print("Error loading image");
                    }
                })
            }
        }
        task.resume()
    }
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image! 😢")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.animationPerformed = false
        if self.grayView != nil {
            self.grayView!.removeFromSuperview()
        }
        if self.dotsView != nil {
            self.dotsView!.removeFromSuperview()
        }
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
        //        var arrWithDots: [String] = []
        //        for index in arrWithSectionNames.indices {
        //            if index == 0 || index % 2 == 0 {
        //                arrWithDots.append(arrWithSectionNames[index])
        //            } else {
        //                arrWithDots.append("•")
        //            }
        //        }
        //        return arrWithDots
        return arrWithSectionNames
    }
    
    var timeOfStart: Timer?
        
        @objc func stopAnimation(){
            timeOfStart?.invalidate()
            self.animationPerformed = true
            self.performSegue(withIdentifier: "goToFriendCollectionVC", sender: self)
        }
        
        func animation(){
                        
            timeOfStart = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(stopAnimation), userInfo: nil, repeats: false)
            
            self.grayView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
            self.grayView!.backgroundColor = .lightGray
            self.grayView!.layer.opacity = 0.5
        
            self.view.addSubview(self.grayView!)
            
            self.dotsView = UIView(frame: CGRect(x: self.grayView!.bounds.width/2-50, y: self.grayView!.bounds.height/2-15, width: 100, height: 30))
            self.dotsView!.backgroundColor = .gray
            self.dotsView!.layer.cornerRadius = 15
            self.dotsView!.layer.masksToBounds = true
            self.view.addSubview(self.dotsView!)
            
            let firstDot = UIView(frame: CGRect(x: 25, y: self.dotsView!.bounds.height/2-5, width: 10, height: 10))
            firstDot.backgroundColor = .green
            firstDot.layer.cornerRadius = firstDot.frame.height/2
            self.dotsView!.addSubview(firstDot)
            
            let secondDot = UIView(frame: CGRect(x: 10, y: self.dotsView!.bounds.height/2-5, width: 10, height: 10))
            secondDot.backgroundColor = .yellow
            secondDot.layer.cornerRadius = secondDot.frame.height/2
            self.dotsView!.addSubview(secondDot)
            
            let transform1 = CGAffineTransform(translationX: 60, y: 0)
            let transform2 = transform1.concatenating(CGAffineTransform(translationX: 0, y: 0))
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat, .calculationModeCubicPaced, .autoreverse], animations: {
                UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                    firstDot.transform = transform1
                }
            }, completion: nil)
            
            UIView.animateKeyframes(withDuration: 1, delay: 0.04, options: [.repeat, .calculationModeCubicPaced, .autoreverse], animations: {
                UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1) {
                    secondDot.transform = transform2
                }
            }, completion: nil)
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if animationPerformed == true{
            return true
        } else {
            return false
        }
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


// proverka
