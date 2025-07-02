//
//  MovieDetailRepository.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Combine

struct MovieDetailRepository: MovieDetailInterface {
    
    let network: APIService
    
    func fetchMovieDetail(code: String) -> AnyPublisher<Result<MovieDetailEntity, ByebooMovieError>, Never> {
        return Future<Result<MovieDetailEntity, ByebooMovieError>, Never> { promise in
            self.network.request(
                url: MovieEndPoint.detail.createURLString(),
                method: .get,
                parameters: [
                    "key": Environment.key,
                    "movieCd": code
                ],
                headers: nil,
                responseType: DetailModel.self) { result in
                    switch result {
                    case .success(let data):
                        let movieDetail = data.movieInfoResult.movieInfo
                        let movieDetailEntity = movieDetail.toEntity()
                        promise(.success(.success(movieDetailEntity)))
                    case .failure(let error):
                        promise(.success(.failure(.networkingError)))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
