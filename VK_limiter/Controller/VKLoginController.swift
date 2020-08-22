//
//  VKLoginController.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 02.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
// proverka

import UIKit
import WebKit
import RealmSwift

class VKLoginController: UIViewController {
    
    var token = ""
    var groupsArrayFromAPI: [GroupStructAPI] = []
    var groupsArrayFromAPIWithPhoto: [GroupStructAPIWithPhoto] = []
    
    
    @IBOutlet weak var vkWebView: WKWebView! {
        didSet{
            vkWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        realmDeleteAll()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7502536"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.85")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        vkWebView.load(request)
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String:String]()) { result , param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let tokenn = params["access_token"], let userIdd = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }
        Session.shared.token = tokenn
        Session.shared.userId = userIdd
        print("session token: \(Session.shared.token!)")
        
        loadGroupsWithParsingWithPhoto()
        loadFriendsWithParsingWithPhoto()
        loadFriendsWithParsingWithPhotoToRealm()
        
        performSegue(withIdentifier: "vkLogin", sender: nil)
        decisionHandler(.cancel)
    }
    
    func loadGroupsSimple() {
        
        var urlComponents2 = URLComponents()
        urlComponents2.scheme = "https"
        urlComponents2.host = "api.vk.com"
        urlComponents2.path = "/method/groups.get"
        urlComponents2.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.107")]
        
        
        guard let url = urlComponents2.url else { preconditionFailure("bad URL")}
        var request2 = URLRequest(url: url)
        request2.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request2) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            //            print(json as Any)
        }
        task.resume()
    }
    
    func searchGroups() {
        
        var urlComponents2 = URLComponents()
        urlComponents2.scheme = "https"
        urlComponents2.host = "api.vk.com"
        urlComponents2.path = "/method/groups.search"
        urlComponents2.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "q", value: "bond"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "v", value: "5.85")]
        
        
        guard let url = urlComponents2.url else { preconditionFailure("bad URL")}
        var request2 = URLRequest(url: url)
        request2.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request2) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            //            print(json as Any)
        }
        task.resume()
    }
    
    func loadFriends() {
        
        var urlComponents2 = URLComponents()
        urlComponents2.scheme = "https"
        urlComponents2.host = "api.vk.com"
        urlComponents2.path = "/method/friends.get"
        urlComponents2.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "user_id", value: String(Session.shared.userId!)),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "offset", value: "5"),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "v", value: "5.107")]
        
        guard let url = urlComponents2.url else { preconditionFailure("bad URL")}
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
            //            print(json)
            
            let users = json as! [String: Any]
            
            let response = users["response"] as! [String: Any]
            let items = response["items"] as! [Any]
            for item in items {
                let friend = item as! [String: Any]
                let name = friend["first_name"] as! String
                let surname = friend["last_name"] as! String
                
                let user = UserStructAPI(name: name, lastName: surname)
                //                print(user)
                
            }
        }
        task.resume()
    }
    
    
    
    //    func photosGetAll() {
    //
    //        var urlComponents2 = URLComponents()
    //        urlComponents2.scheme = "https"
    //        urlComponents2.host = "api.vk.com"
    //        urlComponents2.path = "/method/photos.getAll"
    //        urlComponents2.queryItems = [
    //            URLQueryItem(name: "access_token", value: Session.shared.token!),
    //            URLQueryItem(name: "owner_id", value: "205874265"),
    //            URLQueryItem(name: "extended", value: "0"),
    //            URLQueryItem(name: "offset", value: "0"),
    //            URLQueryItem(name: "count", value: "3"),
    //            URLQueryItem(name: "v", value: "5.107")]
    //
    //        guard let url = urlComponents2.url else { preconditionFailure("bad URL")}
    //        var request2 = URLRequest(url: url)
    //        request2.httpMethod = "GET"
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: request2) { data, response, error in
    //            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    //            print(json as Any)
    //        }
    //        task.resume()
    //    }
    
    
    func loadGroupsWithParsing() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "user_id", value: String(Session.shared.userId!)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "50"),
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
            
            let users = json as! [String: Any]
            
            let response = users["response"] as! [String: Any]
            let items = response["items"] as! [Any]
            for item in items {
                let group = item as! [String: Any]
                let id = group["id"] as! Int
                let name = group["name"] as! String
                let screenName = group["screen_name"] as! String
                let photo50 = group["photo_50"] as! String
                
                let currentGroup = GroupStructAPI(id: id, name: name, screenName: screenName, photo50: photo50)
                GroupsDataSingleton.shared.groupsArray?.append(currentGroup)
                self.groupsArrayFromAPI.append(currentGroup)
                
                //                print(currentGroup)
            }
            GroupsDataSingleton.shared.groupsArray = self.groupsArrayFromAPI
            //            print(GroupsDataSingleton.shared.groupsArray as Any)
            
        }
        task.resume()
    }
    
    func loadGroupsWithParsingWithPhoto() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "user_id", value: String(Session.shared.userId!)),
            URLQueryItem(name: "extended", value: "1"),
            //            URLQueryItem(name: "count", value: "3"),
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
            
            let groups = json as! [String: Any]
            
            let response = groups["response"] as! [String: Any]
            let items = response["items"] as! [Any]
            for item in items {
                let group = item as! [String: Any]
                let id = group["id"] as! Int
                let name = group["name"] as! String
                let screenName = group["screen_name"] as! String
                let photo100 = group["photo_100"] as! String
                //                let ourURL = URL(string: photo100)
                //                var photoAsImage: UIImage?
                
                
                // легкий путь добыть фото
                //                DispatchQueue.global().async {
                //                    guard let imageData = try? Data(contentsOf: ourURL!) else { return }
                //                    let image = UIImage(data: imageData)
                //                    DispatchQueue.main.async {
                //                        photoAsImage = image
                //                        let curGrWithPhoto = GroupStructAPIWithPhoto(id: id, name: name, screenName: screenName, photo50: photoAsImage!)
                //                        self.groupsArrayFromAPIWithPhoto.append(curGrWithPhoto)
                //                    }
                //                    GrDatSingWithPhoto.shared.groupsArray = self.groupsArrayFromAPIWithPhoto
                //                    print(GrDatSingWithPhoto.shared.groupsArray as Any)
                //                }
                
                // трудный  путь добыть фото
                self.fetchImage(from: photo100, completionHandler: { (imageData) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            let img = UIImage(data: data)
                            let curGrWithPhoto = GroupStructAPIWithPhoto(id: id, name: name, screenName: screenName, photo100: img!)
                            self.groupsArrayFromAPIWithPhoto.append(curGrWithPhoto)
                            GrDatSingWithPhoto.shared.groupsArray = self.groupsArrayFromAPIWithPhoto
                            //                            print(GrDatSingWithPhoto.shared.groupsArray as Any)
                        }
                    } else {
                        print("Error loading image");
                    }
                })
                
                
                let currentGroup = GroupStructAPI(id: id, name: name, screenName: screenName, photo50: photo100)
                
                
                
                self.groupsArrayFromAPI.append(currentGroup)
                
            }
            GroupsDataSingleton.shared.groupsArray = self.groupsArrayFromAPI
            
            //                print(GroupsDataSingleton.shared.groupsArray as Any)
            
            
        }
        task.resume()
    }
    
    
    func loadFriendsWithParsingWithPhoto() {
        var friendsArrayParsing: [FriendStruct] = []
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "user_id", value: String(Session.shared.userId!)),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "photo_100"),
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
                let friend = item as! [String: Any]
                let id = friend["id"] as! Int
                let firstName = friend["first_name"] as! String
                let lastName = friend["last_name"] as! String
                let photo100 = friend["photo_100"] as! String
                
                // фетчим фото
                self.fetchImage(from: photo100, completionHandler: { (imageData) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            let img = UIImage(data: data)
                            let currentFriend = FriendStruct(id: id, name: firstName, lastName: lastName, photo100: img!)
                            friendsArrayParsing.append(currentFriend)
                            FriendsDataSingleton.shared.friendsArray = friendsArrayParsing
                            //                            print(FriendsDataSingleton.shared.friendsArray as Any)
                            //                            print(FriendsDataSingleton.shared.friendsArray?.count as Any)
                        }
                    } else {
                        print("Error loading image");
                    }
                })
            }
        }
        task.resume()
    }
    
    func loadFriendsWithParsingWithPhotoToRealm() {
//        var friendsArrayParsing: [FriendRealm] = []
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token!),
            URLQueryItem(name: "user_id", value: String(Session.shared.userId!)),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "photo_100"),
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
                let friend = item as! [String: Any]
                let id = friend["id"] as! Int
                let firstName = friend["first_name"] as! String
                let lastName = friend["last_name"] as! String
                let photo100 = friend["photo_100"] as! String
                
                //FriendsDataSingleton.shared.friendsArray = friendsArrayParsing
                
                let currentFriend = FriendRealm(id: id, firstName: firstName, lastName: lastName, photo100: photo100)
//                friendsArrayParsing.append(currentFriend)
//                print(currentFriend)
                
                // получаем друзей из Realm в виде объектов
                // let ourFriendss: Results<FriendRealm> = { realm.objects(FriendRealm.self) }()
                // print(ourFriendss)


                // сохраняем в Realm, если такого объекта еще нет
                // ищем в БД объект с таким же id, если его нет, добавляем в БД, если уже есть, обновляем
                
                let realm = try! Realm()

                let frrr = realm.objects(FriendRealm.self).filter("id == %@", currentFriend.id).first
                if frrr != nil {
                    print("Такой друг есть \(frrr as Any)")
                    try! realm.write {
                        frrr?.firstName = currentFriend.firstName
                        frrr?.lastName = currentFriend.lastName
                        frrr?.photo100 = currentFriend.photo100
                    }
                    let tmpFr = realm.objects(FriendRealm.self).filter("id == %@", currentFriend.id).first
                    print("И мы обновили его данные:  \(tmpFr as Any)")
                } else {
                    print("Такого друга нет \(currentFriend)")
                    try! realm.write {
                        realm.add(currentFriend)
                        print("Но теперь есть")
                    }
                }
                
                
                // фетчим фото
                //                self.fetchImage(from: photo100, completionHandler: { (imageData) in
                //                    if let data = imageData {
                //                        DispatchQueue.main.async {
                //                            let img = UIImage(data: data)
                //
                //                        }
                //                    } else {
                //                        print("Error loading image");
                //                    }
                //                })
            }
        }
        task.resume()
    }
    
    func realmDeleteAll(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
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
    
    
}

