//
//  MovieEndPoint.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Foundation

enum MovieEndPoint: String {
    
    case boxoffice = "/boxoffice/searchDailyBoxOfficeList.json"
    case detail = "/movie/searchMovieInfo.json"
    
    func createURLString() -> String {
        switch self {
        case .boxoffice:
            return Environment.baseURL + self.rawValue
        case .detail:
            return Environment.baseURL + self.rawValue
        }
    }
}
