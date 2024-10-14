//
//  ContentCollectionViewCell.swift
//  VKTest
//
//  Created by Андрей Бабкин on 04.10.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class ContentCollectionViewCell: UICollectionViewCell {

    static let reuseID = "ContentCollectionViewCell"

    var photoModel: Attachment?

    private let contentImageView: UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.contentMode = .scaleAspectFit
        return contentImageView
    }()
    
    private let photoDescriptionLabel: UILabel = {
        let photoDescriptionLabel = UILabel()
        photoDescriptionLabel.font = .systemFont(ofSize: 12)
        return photoDescriptionLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(photoModel: Attachment?) {
        self.photoModel = photoModel
        guard let photo = photoModel?.photo else {
            contentImageView.image = UIImage(named: "ava")
            return
        }
        if let contentImage = photo.sizes?[3].url, let imageURL = URL(string: contentImage) {
            contentImageView.kf.setImage(with: imageURL)
        }
    }

    private func setupUI() {
        contentView.addSubview(contentImageView)
        contentView.addSubview(photoDescriptionLabel)
        
        contentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        photoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
}
