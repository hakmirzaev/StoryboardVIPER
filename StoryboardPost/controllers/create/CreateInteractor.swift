//
//  CreateInteractor.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 21/04/23.
//

import Foundation

protocol CreateInteractorProtocol {
    func apiPostCreate(post: Post)
}

class CreateInteractor: CreateInteractorProtocol {
    var manager: HttpManagerProtocol!
    var response: CreateResponseProtocol!
    
    func apiPostCreate(post: Post) {
        manager.apiPostCreate(post: post, completion: { (result) in
            self.response.onPostCreate(isCreated: result)
        })
    }
    
}
