//
//  DetailViewController.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    private var presenter: DetailPresenter
    private var movieID: String
    private let disposeBag = DisposeBag()
    
    internal init(presenter: DetailPresenter, movieID: String) {
        self.presenter = presenter
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRedux()
    }
    
    private func setupRedux() {
        presenter.getMovieDetail(movieID: movieID)
        presenter.getUserReview(movieID: movieID, page: 1)
        presenter.getVideo(movieID: movieID)
        
        presenter.onGetMovieDetailSuccessDriver.drive(onNext: { [weak self] data in
            print("Detail movie \(data)")
        }).disposed(by: disposeBag)
        presenter.onGetUserReviewSuccessDriver.drive(onNext: { [weak self] data in
            print("user review \(data)")
        }).disposed(by: disposeBag)
        presenter.onGetVideoSuccessDriver.drive(onNext: { [weak self] data in
            print("video review \(data)")
        }).disposed(by: disposeBag)
    }
}
