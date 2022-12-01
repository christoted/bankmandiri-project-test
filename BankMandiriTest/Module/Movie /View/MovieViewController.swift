//
//  MovieViewController.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit
import RxSwift

class MovieViewController: UIViewController {
    
    @IBOutlet weak var cvMovie: UICollectionView!
    private var presenter: MoviePresenter
    private var genreID: String
    private let disposeBag = DisposeBag()
    private var listMovie: [MovieResult] = []
    var totalItems = 0
    var countPage = 1
    
    
    internal init(presenter: MoviePresenter, genreID: String) {
        self.presenter = presenter
        self.genreID = genreID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupRedux()
        setupView()
    }
    
    private func setupRedux() {
        presenter.getListMovieByGenre(genreID: genreID)
        presenter.onGetListMovieSuccessDriver.drive(onNext: { data in
            self.listMovie = data
            self.totalItems = data.count
            self.cvMovie.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        cvMovie.showsVerticalScrollIndicator = false
        cvMovie.setCollectionViewLayout(layout, animated: true)
        cvMovie.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        cvMovie.delegate = self
        cvMovie.dataSource = self
    }

}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == listMovie.count - 1 {
            if totalItems > listMovie.count - 1 {
                countPage = countPage + 1
                presenter.page.accept(countPage)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
                    self?.presenter.refetchListMovieByGenre(genreID: self?.genreID ?? "")
                }
                
                presenter.tempListMovieByGenre.take(3).bind { [weak self] values in
                    if !values.isEmpty {
                        values.forEach { movie in
                            self?.listMovie.append(movie)
                            self?.cvMovie.reloadData()
                        }
                        self?.totalItems = self?.listMovie.count ?? 0
                    }
                }.disposed(by: disposeBag)
                
            }
            else {

            }
        }
        
        guard let cell = cvMovie.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            fatalError()
        }
        cell.setupMovie(movie: listMovie[indexPath.row])
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 135)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.onTapListMovieToMovieDetail(movieID: listMovie[indexPath.row].id ?? 0) { movieID in
            let presenter = DetailPresenter(movieUseCase: Injection.shared.provideMovieUseCase())
            let vc = DetailViewController(presenter: presenter, movieID: movieID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}
