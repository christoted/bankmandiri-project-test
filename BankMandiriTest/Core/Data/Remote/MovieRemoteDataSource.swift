//
//  MovieRemoteDataSource.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import Alamofire
import RxSwift

internal protocol MovieRemoteDataSourceProtocol {
    func getListGenre() -> Observable<GenreResponse>
    func getDiscoverMovieByGenre(genreID: String, page: Int) -> Observable<DiscoverResponse>
    func getMovieById(movieID: String) -> Observable<MovieResponse>
    func getUserReview(movieID: String, page: Int) -> Observable<ReviewResponse>
    func getVideo(movieID: String) -> Observable<VideoResponse>
}

internal class MovieRemoteDataSourceImpl: MovieRemoteDataSourceProtocol {
   
    static let shared = MovieRemoteDataSourceImpl()
    internal func getListGenre() -> Observable<GenreResponse> {
        let apiKey = Util.shared.getAPIKey()
        let URL = URL(string: Util.shared.getBaseURL()+"3/genre/movie/list?api_key=\(apiKey)&language=en-US")
        let request = AF.request(URL!, method: .get)
        return Observable<GenreResponse>.create { observer in
            request.responseDecodable(of: GenreResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    internal func getDiscoverMovieByGenre(genreID: String, page: Int) -> Observable<DiscoverResponse> {
        let apiKey = Util.shared.getAPIKey()
        let URL = URL(string: Util.shared.getBaseURL()+"3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_video=true&page=\(page)&with_genres=\(genreID)")
        let request = AF.request(URL!, method: .get)
        return Observable<DiscoverResponse>.create { observer in
            request.responseDecodable(of: DiscoverResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    internal func getMovieById(movieID: String) -> Observable<MovieResponse> {
        let apiKey = Util.shared.getAPIKey()
        let URL = URL(string: Util.shared.getBaseURL()+"3/movie/\(movieID)?api_key=\(apiKey)&language=en-US")
        let request = AF.request(URL!, method: .get)
        return Observable<MovieResponse>.create { observer in
            request.responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    internal func getUserReview(movieID: String, page: Int) -> Observable<ReviewResponse> {
        let apiKey = Util.shared.getAPIKey()
        let URL = URL(string: Util.shared.getBaseURL()+"3/movie/\(movieID)/reviews?api_key=\(apiKey)&language=en-US&page=\(page)")
        let request = AF.request(URL!, method: .get)
        return Observable<ReviewResponse>.create { observer in
            request.responseDecodable(of: ReviewResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    internal func getVideo(movieID: String) -> Observable<VideoResponse> {
        let apiKey = Util.shared.getAPIKey()
        let URL = URL(string: Util.shared.getBaseURL()+"3/movie/\(movieID)/videos?api_key=\(apiKey)")
        let request = AF.request(URL!, method: .get)
        return Observable<VideoResponse>.create { observer in
            request.responseDecodable(of: VideoResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    
}
