//
//  VKLoginController.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 02.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {

    var token = ""
    
    @IBOutlet weak var vkWebView: WKWebView! {
        didSet{
            vkWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7013952"),
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
        print(params)
        
        guard let tokenn = params["access_token"]/*, let userId = Int(params["userId"]!)*/ else {
            decisionHandler(.cancel)
            return
        }
        self.token = tokenn
        print("token:\(self.token)"/* , userId: \(userId)*/)
        loadGroups()
        performSegue(withIdentifier: "vkLogin", sender: nil)
        decisionHandler(.cancel)
    }
    
    func loadGroups() {

        var urlComponents2 = URLComponents()
        urlComponents2.scheme = "https"
        urlComponents2.host = "api.vk.com"
        urlComponents2.path = "/method/groups.get"
        urlComponents2.queryItems = [
            URLQueryItem(name: "access_token", value: self.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.85")]
        
        
        guard let url = urlComponents2.url else { preconditionFailure("bad URL")}
                var request2 = URLRequest(url: url)
                request2.httpMethod = "GET"
                let session = URLSession.shared
                let task = session.dataTask(with: request2) { data, response, error in
                    let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json as Any)
                }
                task.resume()
        
    }
    
}
