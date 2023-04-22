//
//  HomeRouting.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 19/04/23.
//

import Foundation

protocol HomeRoutingProtocol {
    func navigateCreateScreen()
    func navigateEditScreen()
}

class HomeRouting: HomeRoutingProtocol {
    weak var contoller: HomeViewController!
    
    func navigateCreateScreen() {
        contoller.callCreateViewController()
    }
    
    func navigateEditScreen() {
        contoller.callEditViewController(post: Post(title: "", body: ""))
    }
    
    
}
