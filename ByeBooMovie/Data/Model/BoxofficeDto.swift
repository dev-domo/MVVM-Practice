import UIKit

struct MovieModel: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [BoxofficeDto]
}

// MARK: - DailyBoxOffice
struct BoxofficeDto: Codable {
    let rank: String
    let movieNm: String
    let audiAcc: String
    let movieCd: String
    
    func toEntity() -> BoxofficeEntity {
        .init(
            rank: self.rank,
            name: self.movieNm,
            audienceCount: self.audiAcc,
            code: self.movieCd
        )
    }
}
