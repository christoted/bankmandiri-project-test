//
//  DetailPresenter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class DetailPresenter {
    private let disposeBag = DisposeBag()
    private let router = MovieRouter()
    private let movieUseCase: MovieUseCase
      
    private let onGetMovieDetailSuccessSubject = PublishSubject<MovieResponse>()
    internal var onGetMovieDetailSuccessDriver: Driver<MovieResponse> {
          onGetMovieDetailSuccessSubject.asDriverOnErrorJustComplete()
      }
    
    private let onGetUserReviewSuccessSubject = PublishSubject<[ReviewData]>()
    internal var onGetUserReviewSuccessDriver: Driver<[ReviewData]> {
        onGetUserReviewSuccessSubject.asDriverOnErrorJustComplete()
    }
    
    private let onGetVideoSuccessSubject = PublishSubject<[VideoResult]>()
    internal var onGetVideoSuccessDriver: Driver<[VideoResult]> {
        onGetVideoSuccessSubject.asDriverOnErrorJustComplete()
    }
    
    init(movieUseCase: MovieUseCase) {
      self.movieUseCase = movieUseCase
    }
    
    func getMovieDetail(movieID: String) {
        movieUseCase.getMovieById(movieID: movieID).subscribe(onNext: { [weak self] data in
            self?.onGetMovieDetailSuccessSubject.onNext(data)
        }).disposed(by: disposeBag)
    }
    
    func getUserReview(movieID: String, page: Int) {
        movieUseCase.getUserReview(movieID: movieID, page: page).subscribe(onNext: { [weak self] data in
            self?.onGetUserReviewSuccessSubject.onNext(data.results)
        }).disposed(by: disposeBag)
    }
    
    func getVideo(movieID: String) {
        movieUseCase.getVideo(movieID: movieID).subscribe(onNext: { [weak self] data in
            self?.onGetVideoSuccessSubject.onNext(data.results)
        }).disposed(by: disposeBag)
    }
}
