//
//  EditInteractor.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 21/04/23.
//

import Foundation

protocol EditInteractorProtocol {
    func apiPostEdit(post: Post)
}

class EditInteractor: EditInteractorProtocol {
    var manager: HttpManagerProtocol!
    var response: EditResponseProtocol!
    
    func apiPostEdit(post: Post) {
        manager.apiPostEdit(post: post, completion: { (result) in
            self.response.onPostEdit(isEdited: result)
        })
    }
    
}
