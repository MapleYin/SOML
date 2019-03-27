//
//  TimeLineViewController.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/22.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import AsyncDisplayKit

class TimeLineViewController: ASViewController<TimeLineTableNode> {
    
    init() {
        super.init(node: TimeLineTableNode())
        self.setupTabbarData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationData()
        
        self.setupTableNode()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}


// MARK: - UI
extension TimeLineViewController {
    
    // base setting
    
    func setupNavigationData() {
        self.navigationItem.title = "SOML"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
    }
    
    func setupTabbarData() {
        self.tabBarItem.title = "时间线"
        self.tabBarItem.image = UIImage(named: "timeline")
        self.tabBarItem.selectedImage = UIImage(named: "timeline")
    }
    
    func setupTableNode() {
        self.node.delegate = self
        self.node.dataSource = self
        self.node.view.separatorStyle = .none
        
        PostManager.shared.addNewPostEventHandler {
            self.node.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
}


extension TimeLineViewController {
    @objc func addNewNote() {
        let ideaController = NewPostViewController(view: IdeaNewPostView())
        ideaController.title = "New Idea"
        let newPostController = UINavigationController(rootViewController: ideaController)
        
        self.present(newPostController, animated: true, completion: nil)
        return ;
        let newPostSelect = NewPostSelectViewController { controller in
            self.present(controller, animated: true, completion: nil)
        }
        
        self.present(newPostSelect, animated: true, completion: nil)
    }
}



extension TimeLineViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
            let success = PostManager.shared.removeItem(at: indexPath.row)
            if success {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        return [action]
    }
}



extension TimeLineViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if let model = PostManager.shared.itemAt(index: indexPath.row) {
            return DailyViewCellNode(with: model)
        }
        return ASCellNode()
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return PostManager.shared.numberOfItem()
    }
}
