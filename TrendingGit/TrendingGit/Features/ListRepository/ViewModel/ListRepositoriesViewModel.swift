//
//  ListRepositoriesViewModel.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import Foundation

class ListRepositoriesViewModel {
    
    private var repositoriesResponse = [RepositoryViewModel]()

    
    func numberOfRows(_ section: Int) -> Int {
        return repositoriesResponse.count
    }
    
    func modelAt(_ index: Int) -> RepositoryViewModel {
        return repositoriesResponse[index]
    }
    
    func searchRepositories(for repository: String, completion: @escaping ([RepositoryViewModel]) -> Void) {
        if(repositoriesResponse.count > 0){
            repositoriesResponse = []
        }
        
        let searchUrl = Constants.Urls.urlForSearchRepositories(repositories: repository)

        let repositoryResource = Resource<RepositoriesResponse>(url: searchUrl) { data in
            let repositoriesResponse = try? JSONDecoder().decode(RepositoriesResponse.self, from: data)
            return repositoriesResponse
        }
        
        Webservice().load(resource: repositoryResource) { (result) in
            
            if let repositoryResource = result {
                for repo in repositoryResource.items {
                    self.repositoriesResponse.append(RepositoryViewModel(repository: repo))
                }
                
                completion(self.repositoriesResponse)
            }
        }
        
    }
}

class RepositoryViewModel {

    let item: Repository

    init(repository: Repository) {
        self.item = repository
    }
}
