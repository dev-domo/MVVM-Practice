import UIKit

struct DetailModel: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
}

struct MovieInfo: Codable {
    let movieCd: String
    let movieNm: String
    let openDt: String
    let showTm: String
}
