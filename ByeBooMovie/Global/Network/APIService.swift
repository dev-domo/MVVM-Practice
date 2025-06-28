import UIKit

final class APIService {
    
    private let boxofficeURLString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let movieURLString = "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    private let key = "2439a9bdfcefc1fae47a3efe66b28d4f"
    private lazy var targetDt = getTargetDate()
    
    func fetchBoxofficeList(completion: @escaping (Result<DailyBoxOffice, NetworkError>) -> Void) async {
        guard let url = URL(string: "\(boxofficeURLString)?key=\(key)&targetDt=\(targetDt)") else {
            completion(.failure(NetworkError.notFoundError))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let movieData = try JSONDecoder().decode(MovieModel.self, from: safeData)
                guard let movie = movieData.boxOfficeResult.dailyBoxOfficeList.randomElement() else {
                    completion(.failure(.dataError))
                    return
                }
                completion(.success(movie))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    func fetchMovieDetail(movieCd: String, completion: @escaping (Result<MovieInfo, NetworkError>) -> Void) async {
        guard let url = URL(string: "\(movieURLString)?key=\(key)&movieCd=\(movieCd)") else {
            completion(.failure(NetworkError.notFoundError))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let movieData = try JSONDecoder().decode(DetailModel.self, from: safeData)
                completion(.success(movieData.movieInfoResult.movieInfo))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    private func getTargetDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return formatter.string(from: Date())
        }
        
        return formatter.string(from: yesterday)
    }
}
