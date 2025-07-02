//
//  BoxofficeRepository.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//
import Alamofire
import Combine
import Foundation

struct BoxofficeRepository: BoxofficeInterface {
    
    let network: APIService
    
    func fetchBoxoffice() -> AnyPublisher<Result<BoxofficeEntity, ByebooMovieError>, Never> {
        return Future<Result<BoxofficeEntity, ByebooMovieError>, Never> { promise in
            self.network.request(
                url: MovieEndPoint.boxoffice.createURLString(),
                method: .get,
                parameters: [
                    "key": Environment.key,
                    "targetDt": getTargetDate()
                ],
                headers: nil,
                responseType: MovieModel.self) { result in
                    switch result {
                    case .success(let data):
                        let boxoffice = data.boxOfficeResult.dailyBoxOfficeList.randomElement()
                        if let entity = boxoffice?.toEntity() {
                            promise(.success(.success(entity)))
                        }
                    case .failure:
                        promise(.success(.failure(.networkingError)))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    private func getTargetDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return formatter.string(from: Date())
        }
        
        return formatter.string(from: yesterday)
    }
}
