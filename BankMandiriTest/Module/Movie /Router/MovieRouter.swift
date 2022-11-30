//
//  MovieRouter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation

class MovieRouter {
    init() {
        
    }
    
    func goToDetailMovie(movieID: String, completion: (String)->()) {
        completion(movieID)
    }
}
