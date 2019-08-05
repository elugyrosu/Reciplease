//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by Jordan MOREAU on 04/08/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}
