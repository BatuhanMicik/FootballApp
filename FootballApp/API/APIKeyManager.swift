//
//  APIKeyManager.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/14/25.
//

import Foundation


    func getAPIKey() -> String {
        if let url = Bundle.main.url(forResource: "ApiKey", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try?
                PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
              let key = plist["API_KEY"] as? String {
                  return key
              }
              
            return ""
        
    }

