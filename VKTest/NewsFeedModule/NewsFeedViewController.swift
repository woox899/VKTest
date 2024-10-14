//
//  NewsFeedViewController.swift
//  VKTest
//
//  Created by Андрей Бабкин on 26.09.2024.
//

import UIKit
import SnapKit

final class NewsFeedViewController: UIViewController {
    
    var viewModel: NewsFeedViewModelProtocol
    
    var newsFeedArray = [ResponseItem]()
    var groupArray = [Group]()
    var profileArray = [Profile]()
    
    private let noNetworkLabel: UILabel = {
        let noNetworkLabel = UILabel()
        noNetworkLabel.text = "No internet connection"
        return noNetworkLabel
    }()
    
    private lazy var reloadButton: UIButton = {
        let reloadButton = UIButton()
        reloadButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.backgroundColor = .systemBlue
        reloadButton.layer.cornerRadius = 8
        return reloadButton
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var feedTableView: UITableView = {
        let feedTableView = UITableView()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        feedTableView.separatorStyle = .none
        feedTableView.showsVerticalScrollIndicator = false
        feedTableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: NewsFeedTableViewCell.reuseID)
        return feedTableView
    }()
    
    init(viewModel: NewsFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getNewsFeed()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.configure()
        }
    }
    
    @objc private func refresh() {
        viewModel.getNewsFeed()
        refreshControl.endRefreshing()
    }
    
    @objc private func reload() {
        viewModel.getNewsFeed()
        feedTableView.reloadData()
    }
    
    func configure() {
        if newsFeedArray.isEmpty {
            feedTableView.isHidden = true
            noNetworkLabel.isHidden = false
            reloadButton.isHidden = false
        } else if !newsFeedArray.isEmpty {
            feedTableView.isHidden = false
            noNetworkLabel.isHidden = true
            reloadButton.isHidden = true
        }
    }
    
    private func setupUI() {
        navigationItem.title = "Новости"
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        view.addSubview(feedTableView)
        feedTableView.addSubview(refreshControl)
        view.addSubview(reloadButton)
        view.addSubview(noNetworkLabel)
        
        noNetworkLabel.isHidden = true
        reloadButton.isHidden = true
        
        feedTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        noNetworkLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        reloadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noNetworkLabel.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
}

extension NewsFeedViewController: NewsFeedViewModelDelegate {
    func displayNewsFeed(model: Response) {
        newsFeedArray = model.items
        groupArray = model.groups
        profileArray = model.profiles
        feedTableView.reloadData()
        configure()
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsFeedDetailsViewModel: NewsFeedDetailsViewModelProtocol = NewsFeedDetailsViewModel()
        let currentNews = newsFeedArray[indexPath.row]
        let newsFeedDetailsVC = NewsFeedDetailsViewController(viewModel: newsFeedDetailsViewModel, newsFeedArray: currentNews, group: groupArray.first(where: { $0.id == abs(currentNews.ownerID)}), profile: profileArray.first(where: { $0.id == currentNews.ownerID}))
        navigationController?.pushViewController(newsFeedDetailsVC, animated: true)
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsFeedTableViewCell = feedTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseID, for: indexPath) as? NewsFeedTableViewCell else { return UITableViewCell() }
        let currentNews = newsFeedArray[indexPath.row]
        newsFeedTableViewCell.configure(newsFeedModel: currentNews, groupsModel: groupArray.first(where: {$0.id == abs(currentNews.ownerID)}), profileModel: profileArray.first(where: { $0.id == abs(currentNews.ownerID)}))
        newsFeedTableViewCell.selectionStyle = .none
        return newsFeedTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}

