//
//  GenreRouter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import UIKit

class GenreRouter {
    init() {
        
    }
    
    func goToListMovieByGenre(genre: String, completion: ((String) -> ())) {
        completion(genre)
    }
}
