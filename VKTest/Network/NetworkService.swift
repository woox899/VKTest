//
//  NetworkService.swift
//  VKTest
//
//  Created by Андрей Бабкин on 26.09.2024.
//

import Foundation
import Alamofire

final class NetworkService {

    static var token = ""

    //MARK: - Получить рекомендованные новости
    func getNewsFeed(completion: @escaping (Result<Response, Error >) -> Void) -> Void {
        guard let url = URL(string: "https://api.vk.com/method/newsfeed.get") else {
            return
        }
        
        let params: [String : Any] = [
            "filters" : "post",
            "count" : "100",
            "access_token" : "\(NetworkService.token)",
            "v" : "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let responseData = try? decoder.decode(Welcome.self, from: data) else {
                        return
                    }
                    completion(.success(responseData.response))
                }
            }
        }
    }

    //MARK: - Поставить like (добавить пост в избранное)
    func likesAdd(itemID: Int, ownreID: Int, completion: @escaping (Result<LikesResponse, Error>) -> Void) -> Void {
        guard let url = URL(string: "https://api.vk.com/method/likes.add") else {
            return
        }
        
        let params: [String : Any] = [
            "type" : "post",
            "item_id" : itemID,
            "owner_id" : ownreID,
            "access_token" : "\(NetworkService.token)",
            "v" : "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                if let data = response.data {
                    let docoder = JSONDecoder()
                    guard let responseData = try? docoder.decode(LikesStruct.self, from: data) else {
                        return
                    }
                    completion(.success(responseData.response))
                }
            }
        }
    }
    //MARK: - Убрать like (удалить пост из избранного)
    func likesDelete(itemID: Int, ownreID: Int, completion: @escaping (Result<LikesResponse, Error>) -> Void) -> Void {
        guard let url = URL(string: "https://api.vk.com/method/likes.delete") else {
            return
        }
        let params: [String : Any] = [
            "type" : "post",
            "item_id" : itemID,
            "owner_id" : ownreID,
            "access_token" : "\(NetworkService.token)",
            "v" : "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                if let data = response.data {
                    let docoder = JSONDecoder()
                    guard let responseData = try? docoder.decode(LikesStruct.self, from: data) else {
                        return
                    }
                    completion(.success(responseData.response))
                }
            }
        }
    }
}
