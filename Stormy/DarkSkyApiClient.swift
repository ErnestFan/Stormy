//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by Ernest Fan on 2017-07-05.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    
    fileprivate let apiKey = "b14568b72a8d97b47604c36144525449"
    
    lazy var baseUrl:URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?,DarkSkyError?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate,completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let currentWeatherJson = json["currently"] as? [String: AnyObject] , let currentWeather = CurrentWeather(json: currentWeatherJson) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
                
                completion(currentWeather, nil)
            }
        }
        task.resume()
    }
}
