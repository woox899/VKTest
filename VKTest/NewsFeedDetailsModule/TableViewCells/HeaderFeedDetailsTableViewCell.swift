//
//  TopFeedDetailsTableViewCell.swift
//  VKTest
//
//  Created by Андрей Бабкин on 27.09.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class HeaderFeedDetailsTableViewCell: UITableViewCell {

    static let reuseID = "TopFeedDetailsTableViewCell"

    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.contentMode = .scaleAspectFit
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(newsFeedModel: ResponseItem, groupModel: Group?, profileModel: Profile?) {
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
        
        if let groupName = groupModel?.name {
            autorsNameLabel.text = groupName
        }
        
        if let groupImage = groupModel?.photo200, let imageURL = URL(string: groupImage) {
            avatarImageView.kf.setImage(with: imageURL)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(autorsNameLabel)
        contentView.addSubview(dateOfNewsLabel)

        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
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
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

