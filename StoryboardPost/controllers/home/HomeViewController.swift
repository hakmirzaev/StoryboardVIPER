//
//  HomeViewController.swift
//  StoryboardPost
//
//  Created by Bekhruz Hakmirzaev on 09/04/23.
//

import UIKit


protocol HomeRequestProtocol {
    func apiPostList()
    func apiPostDelete(post: Post)
    
    func navigateCreateScreen()
    func navigateEditScreen(post: Post)
}

protocol HomeResponseProtocol {
    func onPostList(posts: [Post])
    func onPostDelete(isDeleted: Bool)
}

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var items = Array<Post>()
    var presenter: HomeRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
    }
    
    func refreshTableView(posts: [Post]) {
        self.items = posts
        self.tableView.reloadData()
    }
    
    func onPostList(posts: [Post]) {
        self.hideProgress()
        self.refreshTableView(posts: posts)
    }
    
    func onPostDelete(isDeleted: Bool) {
        self.hideProgress()
        presenter.apiPostList()
    }
    
    // MARK: - Method
    func initViews(){
        tableView.dataSource = self
        tableView.delegate = self
        
        initNavigation()
        configureViper()
        
        presenter.apiPostList()
    }
    
    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard VIPER"
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let routing = HomeRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.contoller = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(post: Post) {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.post = post
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @objc func leftTapped(){
        presenter.apiPostList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self, options: nil)?.first as! PostTableViewCell
        
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        return UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])])
    }
    
    // MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE HERE")
            
            self.presenter.apiPostDelete(post: post)
            completion(true)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("COMPLETE HERE")
            self.callEditViewController(post: post)
            completion(true)
        }
    }
}
