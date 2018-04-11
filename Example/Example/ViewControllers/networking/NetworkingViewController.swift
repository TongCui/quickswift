//
//  NetworkingViewController.swift
//  Example
//
//  Created by tcui on 12/1/2018.
//  Copyright © 2018 LuckyTR. All rights reserved.
//

import UIKit
import Alamofire
import OHHTTPStubs
import QuickSwift


enum Requests: RequestFactory {
    var host: String { return "https://localhost" }
    
    case users
    case createUser
    case readUser(username: String)
    case updateUser(username: String, newname: String)
    case destroyUser(username: String)
    
    func toRequestModel() -> RequestModel {
        switch self {
        case .users:
            return RequestModel(.get, .http, host, "/users")
        case .createUser:
            return RequestModel(.get, .http, host, "/user/create")
        case .readUser(let username):
            return RequestModel(.get, .http, host, "/user/read", ["name": username])
        case .updateUser(let username, let newname):
            return RequestModel(.post, .http, host, "/user/update", ["old": username, "new": newname], .body)
        case .destroyUser(let username):
            return RequestModel(.post, .http, host, "/user/remove", ["name": username], .jsonBody)
        }
    }
}

struct Student: Codable {
    var name: String
    var age: Int
}

struct DefaultResponse<T: Codable> : Codable {
    var model: T?
    
    enum CodingKeys: String, CodingKey {
        case model = "data"
    }
}

final class NetworkingAdapter: TableViewAdapterProtocol {
    
    weak var tableView: UITableView?
    var sections: [SectionItemProtocol] = []
    
    lazy var dataSourceHandler: TableDataSourceHandlerProtocol? = TableViewDataSourceHandler(adapter: self)
    lazy var delegateHandler: TableDelegateHandlerProtocol? = TableViewDefaultDelegateHandler(adapter: self)
    
    required init() {}
    
}

protocol PageLoader {
    var hasMore: Bool { get set }
}

extension UIRefreshControl {
    func refreshManually(tableView: UITableView, refresh:@escaping ()->()) {
        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - frame.height), animated: true)
        self.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            refresh()
        }
    }
}

extension NetworkingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.refreshControl.isRefreshing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.refresh()
            }
        }
    }
    
}

final class NetworkingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter = NetworkingAdapter(tableView: tableView)
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.reloadData()
        adapter.delegateHandler?.scrollDelegate = self
        tableView.refreshControl = refreshControl
        httpStubs()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshButtonDidPress))
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        refresh()
    }
    
    @objc
    func refreshButtonDidPress() {
        refreshControl.refreshManually(tableView: tableView) {
            self.refresh()
        }
    }
    
    func refresh() {
        Alamofire.request(Requests.users).responseModel(type: DefaultResponse<[Student]>.self) { [weak self] (response) in
            if let students = response.result.value?.model {
                students.forEach { print(try! $0.toJSONString()) }
                self?.update(students: students)
            } else {    
                print("Loading failed \(response.result.error!)")
            }
        }
    }
    
    func update(students: [Student]) {
        
        adapter.clear()
        
        adapter.append(section: {PlainSectionItem()} ) {
            students.map { student -> OneLineTextCellItem in
                let ageMessage = "My name is \(student.name), my age is \(student.age)"
                return OneLineTextCellItem(text: "Student: \(student.name)").add(action: .cellDidSelect) { _ in
                    print(ageMessage)
                }
            }
        }
        
        
        adapter.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func httpStubs() {
        stub(condition: isPath("/users")) { _ in
            let stubPath = OHPathForFile("stub-students.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
