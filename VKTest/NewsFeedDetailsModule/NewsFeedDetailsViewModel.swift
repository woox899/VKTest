//
//  NewsFeedDetailsViewModel.swift
//  VKTest
//
//  Created by Андрей Бабкин on 01.10.2024.
//

import UIKit

protocol NewsFeedDetailsViewModelProtocol: AnyObject {
    func likesAdd(itemID: Int, ownerID: Int)
    func likesDelete(itemID: Int, ownerID: Int)
    
    var delegate: NewsFeedDetailsViewModelDelegate? { get set }
}

protocol NewsFeedDetailsViewModelDelegate: AnyObject {
    func setLike(model: LikesResponse)
    func displayPrivatePhoto(photo: Photo)
}

class NewsFeedDetailsViewModel: NewsFeedDetailsViewModelProtocol {

    var delegate: NewsFeedDetailsViewModelDelegate?

    var networkManager = NetworkService()
    
    private var itemID: Int = Int()
    private var ownerID: Int = Int()

    func likesAdd(itemID: Int, ownerID: Int) {
        self.networkManager.likesAdd(itemID: itemID, ownreID: ownerID) { [weak self]  result in
            switch result {
            case .success(let model):
                self?.delegate?.setLike(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func likesDelete(itemID: Int, ownerID: Int) {
        self.networkManager.likesDelete(itemID: itemID, ownreID: ownerID) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.setLike(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
