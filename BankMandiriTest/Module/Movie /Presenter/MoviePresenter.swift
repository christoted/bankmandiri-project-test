//
//  MoviePresenter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class MoviePresenter {

  private let disposeBag = DisposeBag()
  private let router = MovieRouter()
  private let movieUseCase: MovieUseCase
    
    internal var page = BehaviorRelay<Int>(value: 1)
    
    private let onGetListMovieSuccessSubject = PublishSubject<[MovieResult]>()
    internal var onGetListMovieSuccessDriver: Driver<[MovieResult]> {
        onGetListMovieSuccessSubject.asDriverOnErrorJustComplete()
    }
    
    var tempListMovieByGenre = BehaviorRelay<[MovieResult]>(value: [])
  
  init(movieUseCase: MovieUseCase) {
    self.movieUseCase = movieUseCase
  }
  
    func getListMovieByGenre(genreID: String) {
        movieUseCase.getDiscoverMovieByGenre(genreID: genreID, page: page.value)
            .observe(on: ConcurrentMainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
            self?.onGetListMovieSuccessSubject.onNext(data.results)
        }).disposed(by: disposeBag)
    }
    
    func refetchListMovieByGenre(genreID: String) {
        tempListMovieByGenre.accept([])
        movieUseCase.getDiscoverMovieByGenre(genreID: genreID, page: page.value)
            .observe(on: ConcurrentMainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
            self?.tempListMovieByGenre.accept(data.results)
        }, onError: { err in
        }).disposed(by: disposeBag)
    }
    
    func onTapListMovieToMovieDetail(movieID: Int, completion: (String)->()) {
        router.goToDetailMovie(movieID: "\(movieID)") { genre in
            completion(genre)
        }
    }
}
