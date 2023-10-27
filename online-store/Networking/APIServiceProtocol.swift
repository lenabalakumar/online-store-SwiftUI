//
//  APIServiceProtocol.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 25/10/2023.
//

import Foundation

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<[T], APIError>) -> Void)
}
