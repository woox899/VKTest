//
//  NewsFeedTableViewCell.swift
//  VKTest
//
//  Created by Андрей Бабкин on 27.09.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class NewsFeedTableViewCell: UITableViewCell {
    
    static let reuseID = "NewsFeedTableViewCell"
    
    var newsFeedModel: ResponseItem?
    var profileModel: Profile?
    var groupsModel: Group?

    private let backgroundCellView: UIView = {
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = .white
        backgroundCellView.layer.cornerRadius = 18
        return backgroundCellView
    }()

    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    private let autorsNameLabel: UILabel = {
        let autorsNameLabel = UILabel()
        autorsNameLabel.font = .boldSystemFont(ofSize: 14)
        return autorsNameLabel
    }()

    private let dateOfNewsLabel: UILabel = {
        let dateOfNewsLabel = UILabel()
        dateOfNewsLabel.font = .monospacedSystemFont(ofSize: 10, weight: .light)
        return dateOfNewsLabel
    }()
    
    private let newsTextLabel: UILabel = {
        let newsTextLabel = UILabel()
        newsTextLabel.font = .systemFont(ofSize: 14)
        return newsTextLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(newsFeedModel: ResponseItem, groupsModel: Group?, profileModel: Profile?) {
        self.newsFeedModel = newsFeedModel
        self.profileModel = profileModel
        self.groupsModel = groupsModel
        
        newsTextLabel.text = newsFeedModel.text
        guard let timeResult = newsFeedModel.date else { return }
        let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        dateOfNewsLabel.text = localDate
        
        if let firstName = profileModel?.firstName, let lastName = profileModel?.lastName {
            autorsNameLabel.text = firstName + " " + lastName
        }
        
        if let profileImage = profileModel?.photo100, let imageURL = URL(string: profileImage) {
            avatarImageView.kf.setImage(with: imageURL)
        }
        
        if let groupName = groupsModel?.name {
            autorsNameLabel.text = groupName
        }
        
        if let groupImage = groupsModel?.photo200, let imageURL = URL(string: groupImage) {
            avatarImageView.kf.setImage(with: imageURL)
        }
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        contentView.addSubview(backgroundCellView)
        backgroundCellView.addSubview(avatarImageView)
        backgroundCellView.addSubview(autorsNameLabel)
        backgroundCellView.addSubview(dateOfNewsLabel)
        backgroundCellView.addSubview(newsTextLabel)
        
        backgroundCellView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        autorsNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }

        dateOfNewsLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            make.top.equalTo(autorsNameLabel.snp.bottom).offset(8)
        }
        
        newsTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
        }
    }
}
