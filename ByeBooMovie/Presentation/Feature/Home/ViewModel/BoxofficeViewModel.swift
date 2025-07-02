import Foundation

final class BoxofficeViewModel: ViewModelType {
    
    struct Input {
        let handleNexButtonDidTap: () async -> Void
    }
    
    struct Output {
        var updateUI = Observable<DailyBoxOffice?>(nil)
    }
    
    private let apiService: APIService
    var output: Output?
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        self.output = output
        
        Task {
            await input.handleNexButtonDidTap()
        }
        
        return output
    }
    
    func handleNextButtonDidTap() async {
        do {
            let movie = try await apiService.fetchBoxofficeList()
            
            let data = DailyBoxOffice(
                rank: movie.rank,
                movieNm: movie.movieNm,
                audiAcc: formatAudience(movie.audiAcc),
                movieCd: movie.movieCd
            )
            output?.updateUI.data = data
        } catch {
            output?.updateUI.data = nil
        }
    }
    
    private func handleError(_ error: ByebooMovieError) {
        switch error {
        case .dataError:
            print("데이터 에러")
        case .networkingError:
            print("네트워킹 에러")
        case .notFoundError:
            print("잘못된 url")
        case .parseError:
            print("데이터 파싱 에러")
        }
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
    
    func getDetailViewModel(from code: String) -> DetailViewModel {
        return DetailViewModel(apiService: self.apiService, code: code)
    }
}
