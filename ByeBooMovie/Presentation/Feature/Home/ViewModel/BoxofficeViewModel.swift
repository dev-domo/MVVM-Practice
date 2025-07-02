import Combine
import Foundation

final class BoxofficeViewModel: ViewModelType {
    
    struct Input {
        let handleNexButtonDidTap: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let result: AnyPublisher<Result<BoxofficeEntity, ByebooMovieError>, Never>
    }
    
    private var output: PassthroughSubject<Result<BoxofficeEntity, ByebooMovieError>, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    private let boxofficeUseCase: BoxofficeUseCase
    
    init(boxofficeUseCase: BoxofficeUseCase) {
        self.boxofficeUseCase = boxofficeUseCase
    }
    
    func transform(input: Input) -> Output {
        input.handleNexButtonDidTap
            .sink { self.getBoxoffice() }
            .store(in: &cancellables)
        return Output(result: output.eraseToAnyPublisher())
    }
    
    func getBoxoffice() {
        boxofficeUseCase.fetchBoxoffice()
            .sink { [weak self] result in
                self?.output.send(result)
            }
            .store(in: &cancellables)
    }
    
    func formatAudience(_ audience: String) -> String {
        guard let number = Int(audience) else { return "" }
        
        if number >= 10_000 {
            let unit = Double(number) / 10_000.0
            let formatted = String(format: "%.1f", unit)
            return "\(formatted)만명"
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formatted = numberFormatter.string(from: NSNumber(value: number)) else {
            return ""
        }
        return "\(formatted)명"
    }
}
