//
//  CommentsController.swift
//  Discus
//
//  Created by Tim Ng on 4/19/19.
//  Copyright © 2019 Tim Ng. All rights reserved.
//

import UIKit

class CommentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CommentInputAccessoryViewDelegate {
    
    var comments = [Comment]()
    
    private let cellId = "commentCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .bgGray
        
        navigationItem.title = "Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
    }
    
    lazy var containerView: CommentInputAccessoryView = {
          let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        commentInputAccessoryView.delegate = self
        return commentInputAccessoryView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func didSubmit(for comment: String) {
        let comment = Comment(text: comment)
        comments.append(comment)
        containerView.resetInputAccessoryView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 1. Set dummyCell to help layout the content later
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = CommentCell(frame: frame)
        
        // 2. Add the actual content into the dummy cell
        dummyCell.comment = comments[indexPath.item]
        
        // 3. Ask AutoLayout to the layout the content
        dummyCell.layoutIfNeeded()
        
        // 4. Set the maximum target size of the cell
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        
        // 5. Set the estimated size from AutoLayout
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
        // 6. Determine the estimated height and
        // the minimum height
        let height = max(40 + 8 + 8, estimatedSize.height)
        
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
