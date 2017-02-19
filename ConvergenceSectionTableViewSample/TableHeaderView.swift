//
//  TableHeaderView.swift
//  ConvergenceSectionTableViewSample
//
//  Created by 久保島 祐磨 on 2017/02/19.
//  Copyright © 2017年 ICT Fractal Inc. All rights reserved.
//

import UIKit

protocol TableHeaderViewDelegate: class {
	/// 収束状態の変更要求
	func changeConvergenceState(view: TableHeaderView, section: Int)
}

class TableHeaderView: UILabel {
	
	fileprivate var section: Int = 0
	weak var delegate: TableHeaderViewDelegate? = nil
	
	convenience init(section: Int) {
		self.init(frame: CGRect.zero)
		self.section = section
		self._init()
	}

}

// MARK: - fileprivate functions
fileprivate extension TableHeaderView {
	func _init() {
		self.isUserInteractionEnabled = true
		self.textAlignment = .center
		
		self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleView_Tap(sender:))))
	}
	
	@objc func handleView_Tap(sender: UITapGestureRecognizer) {
		self.delegate?.changeConvergenceState(view: self, section: self.section)
	}
}
