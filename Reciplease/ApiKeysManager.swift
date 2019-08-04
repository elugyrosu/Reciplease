//
//  ApiKeys.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 18/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// get API Keys from ApiKeys.plist (git ignored) -> NS Dictionnary

final class ApiKeysManager{
    
    private static var apiKeysPlist: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else{
            fatalError("no dictionnary")
        }
        return NSDictionary(contentsOfFile: path) ?? [:]
        
    }()
    
    static var edamamApiKey: String{
        return apiKeysPlist["edamamApiKey"] as? String ?? String()
    }
}

