//
//  EditRouting.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 21/04/23.
//

import Foundation

protocol EditRoutingProtocol {
    func navigateHomeScreen()
}

class EditRouting: EditRoutingProtocol {
    weak var contoller: EditViewController!
    
    func navigateHomeScreen() {
        contoller.callHomeViewController()
    }
    
}
