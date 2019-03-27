//
//  TextViewCell.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/31.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import UIKit
import SnapKit
import Photos

extension UITableView {
    func updateCellHeigt(animated: Bool = true) {
        UIView.setAnimationsEnabled(animated)
        self.beginUpdates()
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}


extension UITableViewCell {
    /// Search up the view hierarchy of the table view cell to find the containing table view
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
    
    func heightNeedUpdate(animated: Bool = true) {
        if let table = self.tableView {
            table.updateCellHeigt(animated: animated)
        }
    }
}

class TextViewCell: UITableViewCell {
    
    let textView = UITextView()
    let addImageButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.textView.becomeFirstResponder()
    }
    
}


// MARK: - UI
extension TextViewCell {
    func setupUI() {
        self.textView.isScrollEnabled = false
        self.textView.font = UIFont.systemFont(ofSize: 17)
        self.textView.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        self.textView.delegate = self
        self.contentView.addSubview(self.textView)
        
        self.addImageButton.setTitle("✚", for: .normal)
        self.addImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        self.contentView.addSubview(self.addImageButton)
        
        
        self.textView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self.contentView)
            make.height.greaterThanOrEqualTo(200)
        }
        
        self.addImageButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(15)
            make.bottom.equalTo(self.contentView)
            make.top.equalTo(self.textView.snp.bottom)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
    }
    
    
    @objc func pickImage() {
        

        let imagePcikerController = UIImagePickerController()
        imagePcikerController.delegate = self
        
        var responder = self.next
        while !(responder is UIViewController) {
            responder = responder?.next
        }
        
        if responder is UIViewController {
            let vc = responder as! UIViewController
            vc.present(imagePcikerController, animated: true) {
                
            }
        }
    }
}

extension TextViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}


// MARK: - UITextViewDelegate
extension TextViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            self.heightNeedUpdate(animated: false)
        }
    }
}
