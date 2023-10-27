//
//  APIService.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 25/10/2023.
//

import Foundation

struct APIService: APIServiceProtocol {
    
    func fetch<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<[T], APIError>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode([T].self, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.parsingError(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
