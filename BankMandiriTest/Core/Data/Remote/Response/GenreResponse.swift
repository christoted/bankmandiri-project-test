//
//  GenreResponse.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation

internal struct GenreResponse: Codable {
    let genres: [Genre]
}

internal struct Genre: Codable {
    let id: Int?
    let name: String?
}
