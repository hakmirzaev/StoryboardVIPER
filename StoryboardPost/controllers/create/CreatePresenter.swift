//
//  CreatePresenter.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 21/04/23.
//

import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    func apiPostCreate(post: Post)
    
    func navigateHomeScreen()
}

class CreatePresenter: CreatePresenterProtocol {
    
    var interactor: CreateInteractorProtocol!
    var routing: CreateRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiPostCreate(post: Post) {
        controller.showProgress()
        interactor.apiPostCreate(post: post)
    }
    
    func navigateHomeScreen() {
        routing.navigateHomeScreen()
    }
}
