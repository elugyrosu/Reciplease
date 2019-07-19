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
    var urlStringApi: String { get }    // demander pourquoi ?
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
extension EdamamProtocol{
    var urlStringApi: String{
        return "https://api.edamam.com/search\(ApiKeysManager.edamamApiKey)"
    }
}
