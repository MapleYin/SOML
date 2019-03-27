//
//  IdeaNewPostView.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/30.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import UIKit

class IdeaNewPostView: UIView {
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoradFrameChanged(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func becomeFirstResponder() -> Bool {
        if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
            return cell.becomeFirstResponder()
        }
        return self.tableView.becomeFirstResponder()
    }
}


extension IdeaNewPostView: NewPostViewProtocol {
    func newPost() -> PostModel {
        let model = PostModel()
        
        model.content = self.userContent() as NSString
        model.createDate = NSDate()
        
        
        return model
    }
}

extension IdeaNewPostView {
    
    func setupUI() {
        // base set
        self.backgroundColor = UIColor.white

        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        
        
        self.tableView.keyboardDismissMode = .interactive
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TextViewCell.self, forCellReuseIdentifier: "TextViewCell")
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self)
        }
    }
    
    private func userContent() -> String {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextViewCell
        return cell.textView.text
    }
}



// MARK: - Notification
extension IdeaNewPostView {
    @objc func keyBoradFrameChanged(_ notice: Notification) {
        guard let userInfo = notice.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]  as? CGRect else {
                return
        }
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height + 10, right: 0)
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension IdeaNewPostView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as? TextViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    
}
