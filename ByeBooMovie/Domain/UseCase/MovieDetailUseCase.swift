//
//  MovieDetailUseCase.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Combine

protocol MovieDetailUseCaseInterface {
    func fetchMovieDetail(code: String) -> AnyPublisher<Result<MovieDetailEntity, ByebooMovieError>, Never>
}

struct MovieDetailUseCase: MovieDetailUseCaseInterface {
    
    let movieDetailRepository: MovieDetailInterface
    
    func fetchMovieDetail(code: String) -> AnyPublisher<Result<MovieDetailEntity, ByebooMovieError>, Never> {
        movieDetailRepository.fetchMovieDetail(code: code)
    }
}
