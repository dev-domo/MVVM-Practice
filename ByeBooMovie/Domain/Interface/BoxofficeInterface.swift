//
//  BoxofficeInterface.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Combine

protocol BoxofficeInterface {
    func fetchBoxoffice() -> AnyPublisher<Result<BoxofficeEntity, ByebooMovieError>, Never>
}
