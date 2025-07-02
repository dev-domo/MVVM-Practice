import Foundation

final class DetailViewModel {
    
    private let apiService: APIService
    private let code: String
    
    init(apiService: APIService, code: String) {
        self.apiService = apiService
        self.code = code
    }
    
    // 모델
    var movieDetail: MovieInfo? {
        didSet {
            onCompleted(self.movieDetail)
        }
    }
    
    // 인풋
    func handleDetailButtonDidTap() async {
//        await apiService.fetchMovieDetail(movieCd: code) { [weak self] result in
//            switch result {
//            case .success(let movieDetail) :
//                self?.movieDetail = movieDetail
//            case .failure(let error) :
//                self?.handleError(error)
//            }
//        }
    }
    
    // 로직
    var movieName: String? {
        return movieDetail?.movieNm
    }
    
    var openDate: String? {
        guard let dateString = movieDetail?.openDt, !dateString.isEmpty else { return "-" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMdd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return "-"
    }
    
    var runningTime: String? {
        guard let time = movieDetail?.showTm, !time.isEmpty else { return "-" }
        return "\(time)분"
    }
    
    // 아웃풋
    var onCompleted: (MovieInfo?) -> Void = { _ in }
    
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
}
