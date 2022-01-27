//
//  URLLoader.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import Foundation

struct URLLoader {
    static let shared = URLLoader()
    
    func loadForecastData(_ cityName: String, _ completionHandler: @escaping (Result<LSWeather, Error>) -> Void ) {

        let absoluteUrl = GlobalConstants.apiConstants.baseUrl + cityName + GlobalConstants.apiConstants.keyAppender
        var request = URLRequest(url: URL(string: absoluteUrl)!,
                                 timeoutInterval: GlobalConstants.apiConstants.apiTimeout)
        request.httpMethod = GlobalConstants.apiConstants.httpMethod

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            guard let data = data else {
                completionHandler(.failure(NetworkError.emptyData))
                return
            }
            
            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!
            if let forecast = try? JSONDecoder().decode(LSWeather.self, from: jsonData) {
                completionHandler(.success(forecast))
            } else {
                completionHandler(.failure(NetworkError.noCitiesInRegion))
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case keyBadOrMissing
    case badURL
    case emptyData
    case noCitiesInRegion
}

