//
//  GenreRouter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import UIKit

internal class GenreRouter {
    init() {
        
    }
    
    internal func goToListMovieByGenre(genre: String, completion: ((String) -> ())) {
        completion(genre)
    }
}
