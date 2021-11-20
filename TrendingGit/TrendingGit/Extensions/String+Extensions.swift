//
//  String + Extensions.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import Foundation
extension String {
    
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}
