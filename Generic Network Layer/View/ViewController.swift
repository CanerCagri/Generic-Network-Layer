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
        
        NetworkManager.shared.getComments { [weak self] result in
            switch result {
            case .success(let success):
                for email in success {
                    DispatchQueue.main.async {
                        self?.emails.append(email.email!)
                        self?.detailTableView.reloadData()
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
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

