//
//  Util.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation

class Util {
    static let shared = Util()
    
    internal func getAPIKey() -> String {
        return "3c01945072e309f7b79d91d8b23f0b55"
    }
    
    internal func getBaseURLImage() -> String {
        return "https://image.tmdb.org/t/p/original/"
    }
    
    internal func getBaseURL() -> String {
        return "https://api.themoviedb.org/"
    }
    
    private init() {
        
    }
}
