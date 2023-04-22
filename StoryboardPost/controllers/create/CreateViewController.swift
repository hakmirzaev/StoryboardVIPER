//
//  CreateViewController.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

protocol CreateRequestProtocol {
    func apiPostCreate(post: Post)
    
    func navigateHomeScreen()
}

protocol CreateResponseProtocol {
    func onPostCreate(isCreated: Bool)
}


class CreateViewController: BaseViewController, CreateResponseProtocol {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextField!
    var presenter: CreateRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        configureViper()
    }
    
    func onPostCreate(isCreated: Bool) {
        if isCreated {
            self.navigationController?.popViewController(animated: true)
        } else {
            // Error
            print("Error")
        }
    }
    
    func initView() {
        title = "Create Post"
    }
    
    func callHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        let routing = CreateRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.contoller = self
        interactor.manager = manager
        interactor.response = self
    }
    
    @IBAction func createButton(_ sender: Any) {
        if titleLabel.text != nil && bodyLabel.text != nil {
            self.presenter.apiPostCreate(post: Post(title: titleLabel.text!, body: bodyLabel.text!))
        }
    }
    
}
