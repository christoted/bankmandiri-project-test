//
//  GenrePresenter.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import Foundation
import RxSwift
import RxCocoa

internal class GenrePresenter {

  private let disposeBag = DisposeBag()
  private let router = GenreRouter()
  private let movieUseCase: MovieUseCase
    
    private let onGetListGenreSuccessSubject = PublishSubject<[Genre]>()
    internal var onGetListGenreSuccessDriver: Driver<[Genre]> {
        onGetListGenreSuccessSubject.asDriverOnErrorJustComplete()
    }
    
  
  init(movieUseCase: MovieUseCase) {
    self.movieUseCase = movieUseCase
  }
  
    internal func getListGenre() {
        movieUseCase.getListGenre().subscribe(onNext: { [weak self] data in
            self?.onGetListGenreSuccessSubject.onNext(data.genres)
        }).disposed(by: disposeBag)
    }
    
    internal func onTapGenreToListMovie(genre: String, completion: (String) -> ()) {
        router.goToListMovieByGenre(genre: genre) { genre in
            completion(genre)
        }
    }
}
