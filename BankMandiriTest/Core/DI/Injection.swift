//
//  Injection.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation

class Injection {
    static let shared = Injection()
    
    private func provideRepistory() -> MovieRepositoryProtocol {
        return MovieRepositoryImpl(remoteDataSource: MovieRemoteDataSourceImpl.shared)
    }
    
    func provideMovieUseCase() -> MovieUseCase {
        return MovieInteractor(repository: provideRepistory())
    }
}
