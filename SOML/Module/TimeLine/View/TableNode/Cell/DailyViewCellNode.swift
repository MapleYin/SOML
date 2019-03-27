//
//  DailyViewCellNode.swift
//  SOML
//
//  Created by Maple Yin on 2018/12/31.
//  Copyright © 2018 Maple.im. All rights reserved.
//

import AsyncDisplayKit

class DailyViewCellNode: ASCellNode {
    let dateTextNode: ASTextNode2 = ASTextNode2()
    let weekTextNode: ASTextNode2 = ASTextNode2()
    let contentTextNode: ASTextNode2 = ASTextNode2()
    let timeTextNode: ASTextNode2 = ASTextNode2()
    
    
    convenience init(with model: PostModel) {
        self.init()
        
        let createDate = model.createDate as Date
        
        let dateString = "\(createDate.st_day)"
        
        let weekDayString = createDate.st_format("EE")
        
        self.dateTextNode.attributedText = NSAttributedString(string: dateString, attributes: [
            .font: UIFont.systemFont(ofSize: 30)
        ])
        self.weekTextNode.attributedText = NSAttributedString(string: weekDayString, attributes: [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.secondaryText
            ])
        self.contentTextNode.attributedText = NSAttributedString(string: model.content as String, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.mainText
        ])
        
        self.timeTextNode.attributedText = NSAttributedString(string: model.content as String, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.mainText
            ])
        
        
        self.addSubnode(self.dateTextNode)
        self.addSubnode(self.weekTextNode)
        self.addSubnode(self.contentTextNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let dateLayout = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .center, children: [
            self.dateTextNode, self.weekTextNode
        ])
        dateLayout.style.flexShrink = 0
        dateLayout.style.minWidth = ASDimension(unit: .points, value: 80)
        
        
        let contentLayout = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [self.contentTextNode])
        
        contentLayout.style.flexShrink = 1
        
        let stackLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [dateLayout, contentLayout])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 10), child: stackLayout)
    }
}
