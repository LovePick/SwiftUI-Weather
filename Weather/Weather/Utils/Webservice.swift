//
//  Webservice.swift
//  Weather
//
//  Created by Supapon Pucknavin on 17/11/2565 BE.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

func getRequesWith<T: Codable>(type: T.Type, url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.badRequest))
                return
            }
     
            do {
                let decode = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decode))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
    }.resume()
}
