import Alamofire
import UIKit

protocol APIProtocol {
    
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class APIService: APIProtocol {
    
    func request<T>(
        url: String,
        method: HTTPMethod,
        parameters: [String : Any]?,
        headers: HTTPHeaders?,
        responseType: T.Type,
        completion: @escaping (Result<T, any Error>) -> Void
    ) where T : Decodable {
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: headers
        )
            .validate()
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
