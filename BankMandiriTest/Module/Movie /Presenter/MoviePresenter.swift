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
    
    private let onGetListMovieSuccessSubject = PublishSubject<[MovieResult]>()
    internal var onGetListMovieSuccessDriver: Driver<[MovieResult]> {
        onGetListMovieSuccessSubject.asDriverOnErrorJustComplete()
    }
  
  init(movieUseCase: MovieUseCase) {
    self.movieUseCase = movieUseCase
  }
  
    func getListMovieByGenre(genreID: String) {
        movieUseCase.getDiscoverMovieByGenre(genreID: genreID, page: 1).subscribe(onNext: { [weak self] data in
            self?.onGetListMovieSuccessSubject.onNext(data.results)
        }).disposed(by: disposeBag)
    }
    
    func onTapListMovieToMovieDetail(movieID: Int, completion: (String)->()) {
        router.goToDetailMovie(movieID: "\(movieID)") { genre in
            completion(genre)
        }
    }
}
