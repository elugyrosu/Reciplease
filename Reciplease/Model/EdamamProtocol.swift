//
//  EdamamProtocol.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 18/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation
import Alamofire

protocol EdamamProtocol{
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension EdamamProtocol{
    var urlStringApi: String{
        return "https://api.edamam.com/search?app_id=3e840b64&app_key=\(ApiKeysManager.edamamApiKey)&to=100&q="
//        return "https://api.edamam.com/search?app_id=3e840b64&app_key=0&to=100&q="

    }
}
