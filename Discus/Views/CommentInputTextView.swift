//
//  CommentInputTextView.swift
//  Discus
//
//  Created by Tim Ng on 4/19/19.
//  Copyright © 2019 Tim Ng. All rights reserved.
//

import UIKit

protocol CommentInputTextViewDelegate {
    func shouldEnableSubmit(_ enable: Bool)
}

class CommentInputTextView: UITextView {
    
    var commentInputTextViewDelegate: CommentInputTextViewDelegate?
    
    func showPlaceholderLabel() {
        placeHolderLabel.isHidden = false
    }
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a comment..."
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    @objc fileprivate func handleTextChange() {
        placeHolderLabel.isHidden = !self.text.isEmpty
        
        // Validation
        let isFormValid = self.text.count > 0
        commentInputTextViewDelegate?.shouldEnableSubmit(isFormValid)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
