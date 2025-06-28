import Foundation

final class BoxofficeViewModel {
    
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // 모델
    var movie: DailyBoxOffice? {
        didSet {
            onCompleted(self.movie)
        }
    }
    
    // 인풋
    func handleNextButtonDidTap() async {
        await apiService.fetchBoxofficeList() { [weak self] result in
            switch result {
            case .success(let movie) :
                self?.movie = movie
            case .failure(let error) :
                self?.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: NetworkError) {
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
    
    // 로직
    var rank: String? {
        return movie?.rank
    }
    
    var title: String? {
        return movie?.movieNm
    }
    
    var audience: String? {
        guard let numberString = movie?.audiAcc else { return nil }
        guard let number = Int(numberString) else { return nil }
        
        if number >= 10_000 {
            let unit = Double(number) / 10_000.0
            let formatted = String(format: "%.1f", unit)
            return "\(formatted)만명"
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formatted = numberFormatter.string(from: NSNumber(value: number)) else {
            return nil
        }
        return "\(formatted)명"
    }
    
    var code: String? {
        return movie?.movieCd
    }
    
    // 아웃풋
    var onCompleted: (DailyBoxOffice?) -> Void = { _ in }
    
    func getDetailViewModel() -> DetailViewModel {
        return DetailViewModel(apiService: self.apiService, code: code!)
    }
}
