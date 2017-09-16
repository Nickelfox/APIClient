//
//  PaginatorViewController.swift
//  APIClient-Example
//
//  Created by Ravindra Soni on 15/09/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit
import PaginationUIManager
import APIClient

class PaginatorViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	var paginationManager: PaginationUIManager?
	var paginator: IndexPaginator<Number>?
	
	var objects: [Number] {
		return self.paginator?.items ?? []
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.setupPaginationManager()
		self.paginator = IndexPaginator(router: APIRouter.fetchNumbers, initialIndex: 0, limit: 20, paginatorType: .pageBased)
		self.paginationManager?.load {
			
		}
    }
	
	func setupPaginationManager() {
		self.paginationManager = PaginationUIManager(scrollView: self.tableView, pullToRefreshType: .basic)
		self.paginationManager?.delegate = self
	}

}

extension PaginatorViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.objects.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = String(self.objects[indexPath.row].value)
		return cell
	}
}

extension PaginatorViewController: PaginationUIManagerDelegate {

	func refreshAll(completion: @escaping (Bool) -> Void) {
		self.paginator?.refresh(completion: { [weak self] result in
			switch result {
			case .success(let pageInfo):
				self?.tableView.reloadData()
				completion(pageInfo.hasMoreDataToLoad)
			case .failure(let error):
				print("refresh Error: \(error.message)")
				completion(true)
			}
		})
	}
	
	func loadMore(completion: @escaping (Bool) -> Void) {
		self.paginator?.loadNextPage(completion: { [weak self] result in
			switch result {
			case .success(let pageInfo):
				self?.tableView.reloadData()
				completion(pageInfo.hasMoreDataToLoad)
			case .failure(let error):
				print("refresh Error: \(error.message)")
				completion(true)
			}
		})

	}
	
}
