//
//  APIError.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 25/10/2023.
//

import Foundation

enum APIError: Error {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsingError(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "invalid URL"
        case .badResponse(statusCode: let statusCode):
            return "Bad response error with status code \(statusCode)"
        case .url(let urlError):
            return "URL error as \(urlError?.localizedDescription ?? "")"
        case .parsingError(let parsingError):
            return "Parsing error as \(parsingError?.localizedDescription ?? "" )"
        case .unknown:
            return "Unknown error"
        }
        
    }
}
