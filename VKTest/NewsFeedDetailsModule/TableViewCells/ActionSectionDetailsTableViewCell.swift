//
//  ActionSectionDetailsTableViewCell.swift
//  VKTest
//
//  Created by Андрей Бабкин on 28.09.2024.
//

import UIKit
import SnapKit

final class ActionSectionDetailsTableViewCell: UITableViewCell {

    static let reuseID = "ActionSectionDetailsTableViewCell"

    private var likeToggle = false

    var putLike: (() -> Void)?
    var removeLike: (() -> Void)?

    private let likesBackgroundView: UIView = {
        let likesBackgroundView = UIView()
        likesBackgroundView.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 245/255, alpha: 1)
        likesBackgroundView.layer.cornerRadius = 15
        return likesBackgroundView
    }()

    private lazy var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.imageView?.contentMode = .scaleAspectFit
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.addTarget(self, action: #selector(putLikeFunc), for: .touchUpInside)
        return likeButton
    }()

    private let numbersOfLikesLabel: UILabel = {
        let numbersOfLikesLabel = UILabel()
        numbersOfLikesLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return numbersOfLikesLabel
    }()

    private let commentsBackgroundView: UIView = {
        let commentsBackgroundView = UIView()
        commentsBackgroundView.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 245/255, alpha: 1)
        commentsBackgroundView.layer.cornerRadius = 15
        return commentsBackgroundView
    }()

    private let commentsButton: UIButton = {
        let commentsButton = UIButton()
        commentsButton.setImage(UIImage(named: "comment"), for: .normal)
        commentsButton.imageView?.contentMode = .scaleAspectFit
        return commentsButton
    }()

    private let numberOfCommentsLabel: UILabel = {
        let numberOfCommentsLabel = UILabel()
        numberOfCommentsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        numberOfCommentsLabel.text = "186"
        return numberOfCommentsLabel
    }()

    private let repostBackgroundView: UIView = {
        let repostBackgroundView = UIView()
        repostBackgroundView.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 245/255, alpha: 1)
        repostBackgroundView.layer.cornerRadius = 15
        return repostBackgroundView
    }()

    private let repostButton: UIButton = {
        let repostButtton = UIButton()
        repostButtton.setImage(UIImage(named: "share"), for: .normal)
        repostButtton.imageView?.contentMode = .scaleAspectFit
        return repostButtton
    }()

    private let numberOfRepostsLabel: UILabel = {
        let numberOfRepostsLabel = UILabel()
        numberOfRepostsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        numberOfRepostsLabel.text = "190"
        return numberOfRepostsLabel
    }()

    private let viewsImageView: UIImageView = {
        let viewsImageView = UIImageView()
        viewsImageView.image = UIImage(named: "eye")
        return viewsImageView
    }()

    private let numberOfViewsLabel: UILabel = {
        let numberOfViewsLabel = UILabel()
        numberOfViewsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        numberOfViewsLabel.text = "2,4K"
        return numberOfViewsLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: Likes) {
        numbersOfLikesLabel.text = "\(String(describing: model.count))"
    }

    @objc private func putLikeFunc() {
        likeToggle.toggle()
        if likeToggle {
            likeButton.setImage(UIImage(named: "heartRed"), for: .normal)
            putLike?()
        } else {
            likeButton.setImage(UIImage(named: "heart"), for: .normal)
            removeLike?()
        }
    }

    private func setupUI() {
        contentView.addSubview(likesBackgroundView)
        likesBackgroundView.addSubview(likeButton)
        likesBackgroundView.addSubview(numbersOfLikesLabel)
        
        contentView.addSubview(commentsBackgroundView)
        commentsBackgroundView.addSubview(commentsButton)
        commentsBackgroundView.addSubview(numberOfCommentsLabel)
        
        contentView.addSubview(repostBackgroundView)
        repostBackgroundView.addSubview(repostButton)
        repostBackgroundView.addSubview(numberOfRepostsLabel)
        
        contentView.addSubview(numberOfViewsLabel)
        contentView.addSubview(viewsImageView)
        
        likesBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(numbersOfLikesLabel.snp.trailing).inset(-10)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(likesBackgroundView.snp.leading).offset(10)
            make.top.equalTo(likesBackgroundView.snp.top).offset(4)
            make.bottom.equalTo(likesBackgroundView.snp.bottom).offset(-4)
            make.width.equalTo(25)
        }
        
        numbersOfLikesLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        commentsBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(likesBackgroundView.snp.trailing).offset(8)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(numberOfCommentsLabel.snp.trailing).inset(-10)
        }

        commentsButton.snp.makeConstraints { make in
            make.leading.equalTo(commentsBackgroundView.snp.leading).offset(10)
            make.top.equalTo(commentsBackgroundView.snp.top).offset(4)
            make.bottom.equalTo(commentsBackgroundView.snp.bottom).offset(-4)
            make.width.equalTo(25)
        }
        
        numberOfCommentsLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentsButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        repostBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(commentsBackgroundView.snp.trailing).offset(8)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(numberOfRepostsLabel.snp.trailing).inset(-10)
        }
        
        repostButton.snp.makeConstraints { make in
            make.leading.equalTo(repostBackgroundView.snp.leading).offset(10)
            make.top.equalTo(repostBackgroundView.snp.top).offset(4)
            make.bottom.equalTo(repostBackgroundView.snp.bottom).offset(-4)
            make.width.equalTo(25)
        }
        
        numberOfRepostsLabel.snp.makeConstraints { make in
            make.leading.equalTo(repostButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        numberOfViewsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        
        viewsImageView.snp.makeConstraints { make in
            make.trailing.equalTo(numberOfViewsLabel.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
}
