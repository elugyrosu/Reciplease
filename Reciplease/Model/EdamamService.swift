//
//  EdamamService.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 18/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class EdamamService{
    private let edamamSession: EdamamProtocol
    
    init(edamamSession: EdamamProtocol = EdamamSession()){
        self.edamamSession = edamamSession
    }
    
    func getRecipeList(ingredients: String, completionHandler: @escaping (Bool, EdamamRecipes?) -> Void){
        let urlString = edamamSession.urlStringApi + ingredients
        guard let url = URL(string: urlString) else{return}
        edamamSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipeList = try? JSONDecoder().decode(EdamamRecipes.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipeList)
        }
    }
}
