//
//  MovieInteractor.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import RxSwift

internal protocol MovieUseCase {

    func getListGenre() -> Observable<GenreResponse>
    func getDiscoverMovieByGenre(genreID: String, page: Int) -> Observable<DiscoverResponse>
    func getMovieById(movieID: String) -> Observable<MovieResponse>
    func getUserReview(movieID: String, page: Int) -> Observable<ReviewResponse>
    func getVideo(movieID: String) -> Observable<VideoResponse>

}

internal class MovieInteractor: MovieUseCase {

  private let repository: MovieRepositoryProtocol
    
  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
    internal func getListGenre() -> Observable<GenreResponse> {
        return repository.getListGenre()
    }
    
    internal func getDiscoverMovieByGenre(genreID: String, page: Int) -> Observable<DiscoverResponse> {
        return repository.getDiscoverMovieByGenre(genreID: genreID, page: page)
    }
    
    internal func getMovieById(movieID: String) -> Observable<MovieResponse> {
        return repository.getMovieById(movieID: movieID)
    }
    internal func getUserReview(movieID: String, page: Int) -> Observable<ReviewResponse> {
        return repository.getUserReview(movieID: movieID, page: page)
    }
    
    internal func getVideo(movieID: String) -> Observable<VideoResponse> {
        return repository.getVideo(movieID: movieID)
    }
}
