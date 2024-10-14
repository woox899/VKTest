//
//  TextFeedDetailsTableViewCell.swift
//  VKTest
//
//  Created by Андрей Бабкин on 28.09.2024.
//

import UIKit
import SnapKit

final class TextFeedDetailsTableViewCell: UITableViewCell {
    
    static let reuseID = "TextFeedDetailsTableViewCell"
    
    private let textFeedLabel: UILabel = {
        let textFeedLabel = UILabel()
        textFeedLabel.font = .systemFont(ofSize: 14)
        textFeedLabel.numberOfLines = 0
        return textFeedLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(newsFeedModel: ResponseItem) {
        textFeedLabel.text = newsFeedModel.text
    }
    
    private func setupUI() {
        contentView.addSubview(textFeedLabel)
        
        textFeedLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
        }
    }
}
