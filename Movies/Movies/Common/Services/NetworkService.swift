//
//  NetworkService.swift
//  Movies
//
//  Created by Carlos Villamizar on 13/10/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.

import Foundation
import Alamofire

protocol IEndpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameter: Parameters? { get }
    var header: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

class NetworkService {
    static let share = NetworkService()
    
    private var dataRequest: DataRequest?
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "?api_key=62105c98a0dffc156c8472d37aaf606b"
    
    @discardableResult
    private func _dataRequest(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest {
            return SessionManager.default.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    func request<T: IEndpoint>(endpoint: T, completion: @escaping (Swift.Result<Data?, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            let url = self.baseUrl + endpoint.path + self.apiKey
            
            self.dataRequest = self._dataRequest(url: url,
                                                 method: endpoint.method,
                                                 parameters: endpoint.parameter,
                                                 encoding: endpoint.encoding,
                                                 headers: endpoint.header)
            
            self.dataRequest?.responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(let value):
                    
                    print(value)
                    
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
    
    func cancelRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.cancel()
        completion?()
    }
    
    func cancelAllRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.session.getAllTasks(completionHandler: { (tasks) in
            tasks.forEach({ (task) in
                task.cancel()
            })
        })
        completion?()
    }
}

struct BodyStringEncoding: ParameterEncoding {

    private let body: String

    init(body: String) { self.body = body }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
        urlRequest.httpBody = data
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyURLRequest: return "Empty url request"
            case .encodingProblem: return "Encoding problem"
        }
    }
}
