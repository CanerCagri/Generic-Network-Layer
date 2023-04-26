//
//  ViewController.swift
//  Generic Network Layer
//
//  Created by Caner Çağrı on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let detailTableView = UITableView()
    private var users: [String] = []
    private var emails: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
//        getComments(id: 2)
        posts(title: "DENeEME", body: "DENEME", userId: 10)
    }
    
    private func configureTableView() {
        view.addSubview(detailTableView)
        detailTableView.frame = view.bounds
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = .systemBackground
        detailTableView.rowHeight = 40
        detailTableView.layer.cornerRadius = 14
    }
    
//    fileprivate func getComments(id: Int) {
//        NetworkManager.shared.getComments(postId: String(id)) { [weak self] result in
//            switch result {
//            case .success(let success):
//                for email in success {
//                    DispatchQueue.main.async {
//                        self?.emails.append(email.email!)
//                        self?.detailTableView.reloadData()
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    fileprivate func posts(title: String, body: String, userId: Int) {
        NetworkManager.shared.posts(title: title, body: body, userId: userId) { [weak self] result in
            switch result {
            case .success(let success):
                print(success.body)
                print(success.title)
                print(success.userId)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = emails[indexPath.row]
        return cell
    }
}

