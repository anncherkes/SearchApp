//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol SearchViewControllerProtocol: class {
    func reload()
    func endEditing()
    func alert(message: String, title: String)
    func startLoading()
    func finishLoading()
}

public class SearchViewController: UIViewController, SearchViewControllerProtocol {
    
    public var presenter: SearchPresenterProtocol!
    private var searchBar = UISearchBar()
    private var containerView = UIView()
    private var tableView = UITableView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        hideKeyboardWhenTappedAround()
        addContainerView()
        cunfigureViews()
        presenter.getGifs()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "GIPHY"
    }
    
    private func cunfigureViews() {
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: "resultCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        searchBar.delegate = self
    }
    
    private func addContainerView() {
        containerView.frame = CGRect.zero
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: -16).isActive = true
        containerView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        
        addSearchBar()
        addTableView()
    }
    
    private func addSearchBar() {
        searchBar.frame = CGRect.zero
        searchBar.layer.cornerRadius = 5.0
        containerView.addSubview(searchBar)
        let margins = containerView.layoutMarginsGuide
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: margins.topAnchor, constant: -8).isActive = true
        searchBar.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: -8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addTableView() {
        tableView.frame = CGRect.zero
        tableView.layer.cornerRadius = 5.0
        containerView.addSubview(tableView)
        let marginsOfContainer = containerView.layoutMarginsGuide
        let marginsOfTxtField = searchBar.layoutMarginsGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: marginsOfTxtField.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: marginsOfContainer.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: marginsOfContainer.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: marginsOfContainer.bottomAnchor, constant: 0).isActive = true
    }
    
    public func reload() {
        DispatchQueue.main.async {
            self.presenter.getGifs()
            self.tableView.reloadData()
        }
    }
    
    deinit {
        tableView.delegate = nil
        searchBar.delegate = nil
    }
    
    public func endEditing() {
        self.view.endEditing(true)
    }
    
    public func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.view.tintColor = UIColor.gray
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func startLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect.zero
        tableView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        let verticalConstraint = activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        activityIndicator.startAnimating()
    }
    
    public func finishLoading() {
        DispatchQueue.main.async {
            for view in self.tableView.subviews {
                if view.isKind(of: UIActivityIndicatorView.self) {
                    view.removeFromSuperview()
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.gifItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        guard let item = presenter.gifItems[safe: indexPath.row] else { return cell }
        cell.setup(item.url, title: item.title)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancel()
        
        guard let text = searchBar.text else {
            return
        }
        
        if text.count > 1 {
            presenter.search(text)
        } else {
            presenter.cancel()
        }
    }
}
