//
//  ViewController.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 30/05/2019.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, StoryboardLoadable {
    static private let nibID = "NewsCell"
    static private let constPrefetch = 5
    static private let defaultCellHeight: CGFloat = 150.0
    
    typealias ViewModelType = NewsViewModel
    var viewModel: NewsViewModel!
    
    private var refreshControl = UIRefreshControl()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setupTableView()
        setupRefreshControl()
        bindViewModel()
        handleStateUpdate(state: viewModel.state)
    }
    
    @objc func refresh() {
        viewModel.refresh()
    }
    
}

// MARK: - Setup
private extension NewsVC {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NewsVC.nibID, bundle: nil), forCellReuseIdentifier: NewsCell.newsCellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = NewsVC.defaultCellHeight
        tableView.tableFooterView = UIView()
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.tableFooterView?.addSubview(refreshControl)
    }
    
    func bindViewModel() {
        viewModel.onStateChange = { [weak self] (state) in
            self?.handleStateUpdate(state: state)
        }
        
        viewModel.onError = { [weak self] (error) in
            self?.showError(error)
        }
    }
}

// MARK: - Update
private extension NewsVC {
    func handleStateUpdate(state: ViewModelType.State) {
        switch state {
        case .empty:
            tableView.isHidden = true
        case .loading:
            tableView.isHidden = false
        case .withData(let recepies):
            tableView.isHidden = recepies.isEmpty
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource && UITableViewDataDelegate
extension NewsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .withData(let news):
            return news.count
        case .empty:
            return 0
        case .loading:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.newsCellID, for: indexPath) as? NewsCell else {
            fatalError("Can’t deque the cell")
        }
        
        switch viewModel.state {
        case .withData(let news):
            cell.present(news[indexPath.row])
        case .empty, .loading:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - UIScrollViewDelegate
extension NewsVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.hasScrolledToBottom(padding: 150) {
            viewModel.didScrollToBottom()
        }
    }
}
