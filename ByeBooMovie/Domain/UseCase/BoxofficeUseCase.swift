//
//  BoxofficeUseCase.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Combine

protocol BoxofficeUseCaseInterface {
    func fetchBoxoffice() -> AnyPublisher<Result<BoxofficeEntity, ByebooMovieError>, Never>
}

struct BoxofficeUseCase: BoxofficeUseCaseInterface {
    let boxofficeRepository: BoxofficeInterface
    
    func fetchBoxoffice() -> AnyPublisher<Result<BoxofficeEntity, ByebooMovieError>, Never> {
        // UseCase는 Repository에 의존한다
        return boxofficeRepository.fetchBoxoffice()
    }
}
