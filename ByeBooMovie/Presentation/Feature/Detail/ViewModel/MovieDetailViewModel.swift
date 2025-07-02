import Combine
import Foundation

final class MovieDetailViewModel: ViewModelType {
    
    struct Input {
        let handleDetailButtonDidTap: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let result: AnyPublisher<Result<MovieDetailEntity, ByebooMovieError>, Never>
    }
    
    private let movieDetailUseCase: MovieDetailUseCase
    private let movieCode: String
    private var output = PassthroughSubject<Result<MovieDetailEntity, ByebooMovieError>, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    init(movieDetailUseCase: MovieDetailUseCase, movieCode: String) {
        self.movieDetailUseCase = movieDetailUseCase
        self.movieCode = movieCode
    }
    
    func transform(input: Input) -> Output {
        input.handleDetailButtonDidTap
            .sink { self.getMovieDetail() }
            .store(in: &cancellables)
        return Output(result: output.eraseToAnyPublisher())
    }
    
    private func getMovieDetail() {
        movieDetailUseCase.fetchMovieDetail(code: movieCode)
            .sink { result in
                switch result {
                case .success(let entity):
                    self.output.send(.success(entity))
                case .failure(let error):
                    self.output.send(.failure(error))
                }
            }
            .store(in: &cancellables)
    }
    
    func formatDate(_ string: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMdd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"
        
        if let date = inputFormatter.date(from: string) {
            return outputFormatter.string(from: date)
        }
        return "-"
    }
    
    func formatRunnintTime(_ string: String) -> String {
        return "\(string)분"
    }
}
