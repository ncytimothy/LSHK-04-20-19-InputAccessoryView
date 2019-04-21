//
//  CommentInputAccessoryView.swift
//  Discus
//
//  Created by Tim Ng on 4/19/19.
//  Copyright © 2019 Tim Ng. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}

class CommentInputAccessoryView: UIView, CommentInputTextViewDelegate {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    func resetInputAccessoryView() {
        clearCommentTextView()
        resetSubmitButton()
    }
    
    fileprivate func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.showPlaceholderLabel()
    }
    
    fileprivate func resetSubmitButton() {
        submitButton.isEnabled = false
        submitButton.setTitleColor(.outOfFocusBlue, for: .normal)
    }
    
    private let commentTextView: CommentInputTextView = {
        let textView = CommentInputTextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Post", for: .normal)
        submitButton.setTitleColor(UIColor.outOfFocusBlue, for: .normal)
        submitButton.isEnabled = false
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return submitButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commentTextView.commentInputTextViewDelegate = self
        backgroundColor = .white
        
        // 1. Autoresize the accessory view to fit all
        // of the view components
        autoresizingMask = .flexibleHeight
        
        addSubview(submitButton)
        addSubview(commentTextView)
        
        commentTextView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0))

        submitButton.anchor(top: nil, leading: commentTextView.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: 50, height: 50))
        
    }
    
    // Resize when additional text is typed
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    func shouldEnableSubmit(_ enable: Bool) {
        submitButton.isEnabled = enable
        submitButton.setTitleColor(enable ? UIColor.inFocusBlue : UIColor.outOfFocusBlue, for: .normal)
    }
    
    @objc fileprivate func handleSubmit() {
        guard let text = commentTextView.text, text.count > 0 else { return }
        delegate?.didSubmit(for: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
