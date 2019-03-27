//
//  NewPostSelectViewController.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/30.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import AsyncDisplayKit

class NewPostSelectViewController: UIAlertController {
    
    var didSelectPost: ((UIViewController) -> Void)?
    
    convenience init(didSelectPost: @escaping ((UIViewController) -> Void) = {controller in}) {
        self.init(title: "New...", message: nil, preferredStyle: .actionSheet)
        self.didSelectPost = didSelectPost
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupOption()
    }

}

extension NewPostSelectViewController {
    
    func setupOption() {
        // new Idea
        let ideaAction = UIAlertAction(title: "Idea", style: .default) { (action) in
            
            let ideaController = NewPostViewController(view: IdeaNewPostView())
            ideaController.title = "New Idea"
            let newPostController = UINavigationController(rootViewController: ideaController)
            self.didSelectPost?(newPostController)
        }
        
        self.addAction(ideaAction)
        
        
        // cancel
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        self.addAction(cancelAction)
        
    }
    
}
