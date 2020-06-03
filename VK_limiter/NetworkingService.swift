//
//  NetworkingService.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 02.06.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import Foundation

class NetworkingService {
    public func sendRequest() {
        
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "oauth.vk.com"
//        urlComponents.path = "/authorize"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "client_id", value: "7013952"),
//            URLQueryItem(name: "display", value: "mobile"),
//            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//            URLQueryItem(name: "scope", value: "262150"),
//            URLQueryItem(name: "response_type", value: "token"),
//            URLQueryItem(name: "v", value: "5.85")
//        ]
//        
//        let request = URLRequest(url: urlComponents.url!)
//        
        /*
        let url = URL(string: "https:
         //api.openweathermap.org/data/2.5/forecast?q=Moscow&units=metric&appId=8b32f5f2dc7dbd5254ac73d984baf306")
       */
        
        /*
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "Moscow"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appId", value: "8b32f5f2dc7dbd5254ac73d984baf306")
        ]  
        
        guard let url = urlComponents.url else { preconditionFailure("bad URL")}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        
//        let session = URLSession.shared
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(json as Any)
        }
        task.resume()
        */
        
    }
}
