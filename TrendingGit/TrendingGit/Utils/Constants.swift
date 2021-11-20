//
//  Constants.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import Foundation
struct Constants {
    
    struct Urls {
        
        static func urlForSearchRepositories(repositories: String) -> URL {
            
            return URL(string: "https://api.github.com/search/repositories?q=\(repositories.escaped())")!
        }
        
        static func urlForSearchRepositoriesAll() -> URL {
            
            return URL(string: "https://api.github.com/search/repositories")!
        }
        
        static func webViewDefaultValue() -> URL {
            
            return URL(string: "https://www.github.com")!
        }
        
    }
    
}
