//
//  GenreViewController.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class GenreViewController: UIViewController {
    
    @IBOutlet weak var cvGenre: UICollectionView!
    private var presenter: GenrePresenter
    private let disposeBag = DisposeBag()
    private var listGenre: [Genre] = []
    
    internal init(presenter: GenrePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRedux()
        setupView()
    }
    
    private func setupRedux() {
        presenter.getListGenre()
        presenter.onGetListGenreSuccessDriver.drive(onNext: { [weak self ] data in
            self?.listGenre = data
            self?.cvGenre.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        cvGenre.showsVerticalScrollIndicator = false
        cvGenre.setCollectionViewLayout(layout, animated: true)
        cvGenre.register(UINib(nibName: GenreCell.identifier, bundle: nil), forCellWithReuseIdentifier: GenreCell.identifier)
        cvGenre.delegate = self
        cvGenre.dataSource = self
    }
}

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cvGenre.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            fatalError()
        }
        cell.setupGenre(genre: listGenre[indexPath.row].name ?? "")
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = listGenre[indexPath.row].id ?? 0
        presenter.onTapGenreToListMovie(genre: "\(String(describing: genre))") { genreID in
            print(genreID)
            let presenter = MoviePresenter(movieUseCase: Injection.shared.provideMovieUseCase())
            let vc = MovieViewController(presenter: presenter, genreID: genreID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
    }
}
