//
//  NewsFeedDetailsViewController.swift
//  VKTest
//
//  Created by Андрей Бабкин on 26.09.2024.
//

import UIKit
import SnapKit

enum SectionType {
    case first
}

enum RowType {
    case header
    case text
    case content
    case actionSection
}

struct Section {
    var section: SectionType
    var rows: [RowType]
}

final class NewsFeedDetailsViewController: UIViewController {

    var section: [Section] = [.init(section: SectionType.first, rows: [.header, .text, .content, .actionSection])]
    
    var viewModel: NewsFeedDetailsViewModelProtocol

    var news: ResponseItem
    let group: Group?
    let profile: Profile?

    private lazy var newsFeedDetailsTableView: UITableView = {
        let newsFeedDetailsTableView = UITableView()
        newsFeedDetailsTableView.delegate = self
        newsFeedDetailsTableView.dataSource = self
        newsFeedDetailsTableView.separatorStyle = .none
        newsFeedDetailsTableView.showsVerticalScrollIndicator = false
        newsFeedDetailsTableView.register(HeaderFeedDetailsTableViewCell.self, forCellReuseIdentifier: HeaderFeedDetailsTableViewCell.reuseID)
        newsFeedDetailsTableView.register(TextFeedDetailsTableViewCell.self, forCellReuseIdentifier: TextFeedDetailsTableViewCell.reuseID)
        newsFeedDetailsTableView.register(ContentFeedDetailsTableViewCell.self, forCellReuseIdentifier: ContentFeedDetailsTableViewCell.reuseID)
        newsFeedDetailsTableView.register(ActionSectionDetailsTableViewCell.self, forCellReuseIdentifier: ActionSectionDetailsTableViewCell.reuseID)
        return newsFeedDetailsTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(viewModel: NewsFeedDetailsViewModelProtocol, newsFeedArray: ResponseItem, group: Group?, profile: Profile?) {
        self.viewModel = viewModel
        self.news = newsFeedArray
        self.group = group
        self.profile = profile
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(newsFeedDetailsTableView)
        
        newsFeedDetailsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewsFeedDetailsViewController: UITableViewDelegate {

}

extension NewsFeedDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell {
            switch section[indexPath.section].rows[indexPath.row] {
            case .header:
                guard let headerFeedDetailsTableViewCell = newsFeedDetailsTableView.dequeueReusableCell(withIdentifier: HeaderFeedDetailsTableViewCell.reuseID, for: indexPath) as? HeaderFeedDetailsTableViewCell else { return UITableViewCell() }
                headerFeedDetailsTableViewCell.configure(newsFeedModel: news, groupModel: group, profileModel: profile)
                headerFeedDetailsTableViewCell.selectionStyle = .none
                return headerFeedDetailsTableViewCell
            case .text:
                guard let textFeedDetailsTableViewCell = newsFeedDetailsTableView.dequeueReusableCell(withIdentifier: TextFeedDetailsTableViewCell.reuseID, for: indexPath) as? TextFeedDetailsTableViewCell else { return UITableViewCell() }
                textFeedDetailsTableViewCell.configure(newsFeedModel: news)
                textFeedDetailsTableViewCell.selectionStyle = .none
                return textFeedDetailsTableViewCell
            case .content:
                guard let contentFeedDetailsTableViewCell = newsFeedDetailsTableView.dequeueReusableCell(withIdentifier: ContentFeedDetailsTableViewCell.reuseID, for: indexPath) as? ContentFeedDetailsTableViewCell else { return UITableViewCell() }
                contentFeedDetailsTableViewCell.selectionStyle = .none
                contentFeedDetailsTableViewCell.configure(model: news.attachments)
                return contentFeedDetailsTableViewCell
            case .actionSection:
                guard let actionSectionDetailsTableViewCell = newsFeedDetailsTableView.dequeueReusableCell(withIdentifier: ActionSectionDetailsTableViewCell.reuseID, for: indexPath) as? ActionSectionDetailsTableViewCell else { return UITableViewCell() }
                actionSectionDetailsTableViewCell.selectionStyle = .none
                actionSectionDetailsTableViewCell.putLike = {
                    self.viewModel.likesAdd(itemID: self.news.id, ownerID: self.news.ownerID)
                    actionSectionDetailsTableViewCell.configure(model: self.news.likes)
                }
                actionSectionDetailsTableViewCell.removeLike = {
                    self.viewModel.likesDelete(itemID: self.news.id, ownerID: self.news.ownerID)
                    actionSectionDetailsTableViewCell.configure(model: self.news.likes)
                }
                actionSectionDetailsTableViewCell.configure(model: news.likes)
                return actionSectionDetailsTableViewCell
            }
        }
        return cell
    }
}

extension NewsFeedDetailsViewController: NewsFeedDetailsViewModelDelegate {
    func displayPrivatePhoto(photo: Photo) {
        return
    }
    
    func setLike(model: LikesResponse) {
        news.likes.count = model.likes
        newsFeedDetailsTableView.reloadData()
    }
}

