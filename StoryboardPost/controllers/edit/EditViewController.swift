//
//  EditViewController.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

protocol EditRequestProtocol {
    func apiPostEdit(post: Post)
    
    func navigateHomeScreen()
}

protocol EditResponseProtocol {
    func onPostEdit(isEdited: Bool)
}

class EditViewController: BaseViewController, EditResponseProtocol {

    var post: Post = Post(title: "", body: "")
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextField!
    var presenter: EditRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        configureViper()
    }
    
    func onPostEdit(isEdited: Bool) {
        if isEdited {
            self.hideProgress()
            self.dismiss(animated: true, completion: nil)
        } else {
            // Error
            print("Error")
        }
    }
    
    func initView() {
        titleLabel.text = post.title!
        bodyLabel.text = post.body!
        
        title = "Edit Post"
    }
    
    func callHomeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        let routing = EditRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.contoller = self
        interactor.manager = manager
        interactor.response = self
    }

    @IBAction func saveButton(_ sender: Any) {
        if titleLabel.text != nil && bodyLabel.text != nil {
            self.presenter.apiPostEdit(post: Post(id: post.id!, title: titleLabel.text!, body: bodyLabel.text!))
        }
    }

}
