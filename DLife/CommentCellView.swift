//
//  CommentCellView.swift
//  DLife
//
//  Created by Евгений Губин on 21.06.15.
//  Copyright (c) 2015 SimbirSoft. All rights reserved.
//

import UIKit
import MVVMKit

class CommentCellView: UITableViewCell, ViewForViewModel, BindableCellView {
    static var CellIdentifier = "CommentCellView"
    
    var viewModel: DLComment!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    func bindToViewModel() {
        lblHeader.text = "@rating: \(viewModel.voteCount) @author: \(viewModel.authorName) @date: \(viewModel.date)"
        lblMessage.text = viewModel.text
    }
}
