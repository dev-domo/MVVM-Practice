//
//  MovieDetailInterface.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Combine

protocol MovieDetailInterface {
    func fetchMovieDetail(code: String) -> AnyPublisher<Result<MovieDetailEntity, ByebooMovieError>, Never>
}
