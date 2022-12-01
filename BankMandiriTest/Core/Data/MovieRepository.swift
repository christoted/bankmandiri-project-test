//
//  MovieRepository.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import Alamofire
import RxSwift

internal protocol MovieRepositoryProtocol {
    func getListGenre() -> Observable<GenreResponse>
    func getDiscoverMovieByGenre(genreID: String, page: Int) -> Observable<DiscoverResponse>
    func getMovieById(movieID: String) -> Observable<MovieResponse>
    func getUserReview(movieID: String, page: Int) -> Observable<ReviewResponse>
    func getVideo(movieID: String) -> Observable<VideoResponse>
}

internal class MovieRepositoryImpl: MovieRepositoryProtocol {
    internal let remoteDataSource: MovieRemoteDataSourceImpl
    
    internal init(remoteDataSource: MovieRemoteDataSourceImpl) {
        self.remoteDataSource = remoteDataSource
    }
    
    internal func getListGenre() -> Observable<GenreResponse> {
        return remoteDataSource.getListGenre()
    }
    
    internal func getDiscoverMovieByGenre(genreID: String, page: Int) -> Observable<DiscoverResponse> {
        return remoteDataSource.getDiscoverMovieByGenre(genreID: genreID, page: page)
    }
    
    internal func getMovieById(movieID: String) -> Observable<MovieResponse> {
        return remoteDataSource.getMovieById(movieID: movieID)
    }
    
    internal func getUserReview(movieID: String, page: Int) -> Observable<ReviewResponse> {
        return remoteDataSource.getUserReview(movieID: movieID, page: page)
    }
    
    internal func getVideo(movieID: String) -> Observable<VideoResponse> {
        return remoteDataSource.getVideo(movieID: movieID)
    }
}
