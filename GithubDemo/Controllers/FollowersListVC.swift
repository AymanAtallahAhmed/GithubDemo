//
//  FollowersListVCViewController.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FollowersListVC: UIViewController {
    
    private let viewModel: FollowersListViewModel
    private let navigator: Navigator
    private let disposeBag = DisposeBag()
    
    init(viewModel: FollowersListViewModel, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var pageCounter = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupSearcheController()
        
        bind()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.creat3ColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func bind() {
        viewModel.currentFollowers.bind(to: collectionView.rx.items(cellIdentifier: FollowerCell.reuseID, cellType: FollowerCell.self)) { index, model, cell in
            //cell.avatarImageView.image = nil
            cell.follower = model
        }.disposed(by: disposeBag)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.userName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupSearcheController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here for Followers"
        
        navigationItem.searchController = searchController
    }
}


extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !isSearching else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.height
        
        if offsetY > (contentHeight - screenHeight) {
            pageCounter += 1
            viewModel.fetchFollowers(page: pageCounter)
        }
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
            filter != "" else { return }
        viewModel.search(with: filter)
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCanceled()
        isSearching = false
    }
    
}
