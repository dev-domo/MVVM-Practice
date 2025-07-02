//
//  Environment.swift
//  ByeBooMovie
//
//  Created by APPLE on 7/2/25.
//

import Foundation

final class Environment {
    static let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String
    static let key = Bundle.main.infoDictionary?["KEY"] as! String
}
