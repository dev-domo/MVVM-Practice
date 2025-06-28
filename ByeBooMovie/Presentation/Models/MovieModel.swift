import UIKit

struct MovieModel: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOffice]
}

// MARK: - DailyBoxOffice
struct DailyBoxOffice: Codable {
    let rank: String
    let movieNm: String
    let audiAcc: String
    let rankOldAndNew: String
    let movieCd: String
}
