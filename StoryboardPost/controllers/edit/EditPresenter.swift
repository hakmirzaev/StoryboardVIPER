//
//  EditPresenter.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 21/04/23.
//

import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    func apiPostEdit(post: Post)
    
    func navigateHomeScreen()
}

class EditPresenter: EditPresenterProtocol {
    
    var interactor: EditInteractorProtocol!
    var routing: EditRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiPostEdit(post: Post) {
        controller.showProgress()
        interactor.apiPostEdit(post: post)
    }
    
    func navigateHomeScreen() {
        routing.navigateHomeScreen()
    }
}
