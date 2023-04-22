//
//  HomePresenter.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 19/04/23.
//

import Foundation

protocol HomePresenterProtocol: HomeRequestProtocol {
    func apiPostList()
    func apiPostDelete(post: Post)
    
    func navigateCreateScreen()
    func navigateEditScreen(post: Post)
}

class HomePresenter: HomePresenterProtocol {
    var interactor: HomeInteractorProtocol!
    var routing: HomeRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiPostList() {
        controller.showProgress()
        interactor.apiPostList()
    }
    
    func apiPostDelete(post: Post) {
        controller.showProgress()
        interactor.apiPostDelete(post: post)
    }
    
    func navigateCreateScreen() {
        routing.navigateCreateScreen()
    }
    
    func navigateEditScreen(post: Post) {
        routing.navigateEditScreen()
    }
}
