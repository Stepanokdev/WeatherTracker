//
//  API.swift
//  Weather Tracker
//
//  Created by Ivan Stepanok on 15.12.2024.
//


import Foundation
import Alamofire

class API {
    static func sendRequestData(request: EndPoint) async throws -> Data {
        return try await AF.request(request.path,
                                    method: request.httpMethod,
                                    parameters: request.parameters,
                                    encoding: URLEncoding.default)
        .validate(statusCode: 200..<300)
        .serializingData()
        .value
    }
}

protocol EndPoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
}

enum Requests: EndPoint {
    case getWeather(city: String)
    case autoComplete(city: String)

    var path: String {
        switch self {
        case .getWeather:
            return "https://api.weatherapi.com/v1/current.json"
        case .autoComplete:
            return "https://api.weatherapi.com/v1/search.json"
        }
    }

    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        case .autoComplete:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .getWeather(city):
            let parameters: [String: Encodable] = [
                "key": "4cc0fa0f3d5c4949b7e141634241512",
                "q": city
            ]
            return parameters
        case let .autoComplete(city):
            let parameters: [String: Encodable] = [
                "key": "4cc0fa0f3d5c4949b7e141634241512",
                "q": city
            ]
            return parameters
        }
    }
}
