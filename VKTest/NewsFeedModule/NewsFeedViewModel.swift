//
//  NewsFeedViewModel.swift
//  VKTest
//
//  Created by Андрей Бабкин on 01.10.2024.
//

import UIKit

protocol NewsFeedViewModelProtocol: AnyObject {
    func getNewsFeed()
    var delegate: NewsFeedViewModelDelegate? { get set }
}

protocol NewsFeedViewModelDelegate: AnyObject {
    func displayNewsFeed(model: Response)
}


class NewsFeedViewModel: NewsFeedViewModelProtocol {
    
    var delegate: NewsFeedViewModelDelegate?
    
    var networkManager = NetworkService()
    
    func getNewsFeed() {
        networkManager.getNewsFeed { newsFeed in
            switch newsFeed {
            case .success(let model):
                self.delegate?.displayNewsFeed(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
