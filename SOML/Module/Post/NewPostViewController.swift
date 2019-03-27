//
//  NewPostViewController.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/30.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {
    
    private let newPostView: NewPostViewProtocol
    
    init(view: (UIView&NewPostViewProtocol)) {
        self.newPostView = view
        super.init(nibName: nil, bundle: nil)
        self.view = view
        self.setupNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.becomeFirstResponder()
    }
}


// MARK: - UI
extension NewPostViewController {
    func setupNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
}


// MARK: - Action
extension NewPostViewController {
    
    @objc func save() {
        let model = self.newPostView.newPost()
        PostManager.shared.save(model: model)
        self.close()
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
