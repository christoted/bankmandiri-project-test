//
//  DetailViewController.swift
//  BankMandiriTest
//
//  Created by Bang Coding on 30/11/22.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cvDetail: UICollectionView!
    private var presenter: DetailPresenter
    private var movieID: String
    private let disposeBag = DisposeBag()
    var movieResponse: MovieResponse?
    var videoResult: VideoResult?
    var listReview: [ReviewData] = []
    
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
        setupView()
    }
    
    private func setupRedux() {
        presenter.getMovieDetail(movieID: movieID)
        presenter.getUserReview(movieID: movieID, page: 1)
        presenter.getVideo(movieID: movieID)
        
        presenter.onGetMovieDetailSuccessDriver.drive(onNext: { [weak self] data in
            self?.movieResponse = data
            self?.cvDetail.reloadSections(IndexSet(integer: 0))
        }).disposed(by: disposeBag)
        presenter.onGetUserReviewSuccessDriver.drive(onNext: { [weak self] data in
            self?.listReview = data
            self?.cvDetail.reloadSections(IndexSet(integer: 1))
        }).disposed(by: disposeBag)
        presenter.onGetVideoSuccessDriver.drive(onNext: { [weak self] data in
            if !data.isEmpty {
                self?.videoResult = data[0]
                self?.cvDetail.reloadSections(IndexSet(integer: 0))
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        cvDetail.showsVerticalScrollIndicator = false
        cvDetail.setCollectionViewLayout(layout, animated: true)
        cvDetail.register(UINib(nibName: MovieInfoCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieInfoCell.identifier)
        cvDetail.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellWithReuseIdentifier: CommentCell.identifier)
        cvDetail.collectionViewLayout = createCollectionViewLayout()
        cvDetail.delegate = self
        cvDetail.dataSource = self
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return listReview.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:  guard let cell = cvDetail.dequeueReusableCell(withReuseIdentifier: MovieInfoCell.identifier, for: indexPath) as? MovieInfoCell else {
            fatalError()
        }
        cell.setupData(movie: movieResponse, video: videoResult)
       
        return cell
        default:
            guard let cell = cvDetail.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
                fatalError()
            }
            cell.setupData(review: listReview[indexPath.row])
           
            return cell
            
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 400)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {[weak self] (section, _) -> NSCollectionLayoutSection? in
            
            if section == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute((self?.view.frame.width ?? 350) - 16), heightDimension: .absolute(430)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 8, bottom: 0, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute((self?.view.frame.width ?? 350)-16), heightDimension: .absolute(430)),subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                return section
            } else {
                // Horizontal
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(110)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(110)),subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 24, trailing: 8)
                
                return section
            }
            
            return nil
        }
    }
}
