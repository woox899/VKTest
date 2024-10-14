//
//  ContentFeedDetailsTableViewCell.swift
//  VKTest
//
//  Created by Андрей Бабкин on 28.09.2024.
//

import UIKit
import SnapKit

final class ContentFeedDetailsTableViewCell: UITableViewCell {

    static let reuseID = "ContentFeedDetailsTableViewCell"

    var contentArray = [Attachment]()

    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.width = UIScreen.main.bounds.width
        layout.itemSize.height = UIScreen.main.bounds.width
        layout.minimumLineSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentSize.height = layout.itemSize.height
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.reuseID)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: [Attachment]) {
        self.contentArray = model
        contentCollectionView.reloadData()
    }
    
    private func setupUI() {
        contentView.addSubview(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}

extension ContentFeedDetailsTableViewCell: UICollectionViewDelegate {

}

extension ContentFeedDetailsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let contentCollectionViewCell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reuseID, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        contentCollectionViewCell.configure(photoModel: contentArray[indexPath.item])
        return contentCollectionViewCell
    }
}
