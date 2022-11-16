//
//  Error.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}
