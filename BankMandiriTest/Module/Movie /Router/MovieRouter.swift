//
//  MovieRouter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation

internal class MovieRouter {
    init() {
        
    }
    
    internal func goToDetailMovie(movieID: String, completion: (String)->()) {
        completion(movieID)
    }
}
