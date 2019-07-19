//
//  EdamamSession.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 18/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation
import Alamofire

class EdamamSession: EdamamProtocol{
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void){
        Alamofire.request(url).responseJSON { responseData in
            completionHandler(responseData)
        }
    }
}
