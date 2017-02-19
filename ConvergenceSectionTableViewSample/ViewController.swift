//
//  ViewController.swift
//  ConvergenceSectionTableViewSample
//
//  Created by 久保島 祐磨 on 2017/02/19.
//  Copyright © 2017年 ICT Fractal Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	fileprivate lazy var sections: [SectionData] = {
		var sections = [SectionData]()
		
		for section in 0...4 {
			let data = SectionData()
			for row in 0...4 {
				data.rows.append("\(section.description): \(row.description)")
			}
			sections.append(data)
		}
		
		return sections
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let sectionData = self.sections[section]
		
		// 実装ポイント
		// セクションが収束している場合(isConvergence)、0を返します
		return sectionData.isConvergence ? 0 : sectionData.rows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
		if cell == nil {
			cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
		}
		
		cell?.textLabel?.text = self.sections[indexPath.section].rows[indexPath.row]
		
		return cell!
	}
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 60.0
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = TableHeaderView(section: section)
		view.delegate = self
		view.text = "section \(section.description) header"
		view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
		return view
	}
}

// MARK: - TableHeaderViewDelegate
extension ViewController: TableHeaderViewDelegate {
	func changeConvergenceState(view: TableHeaderView, section: Int) {
		// 実装ポイント
		// セクションがタップされた際、該当するセクションの収束状態を反転し、リロードします
		self.sections[section].isConvergence = !self.sections[section].isConvergence
		self.tableView.reloadSections(IndexSet([section]), with: .automatic)
	}
}

// 実装ポイント
// rowの追加/更新/削除/移動は該当するセクションの収束状態によって対応しなければなりません

// 追加の場合
// セクションが収束している場合、tableViewにinsertは行わない

// 更新の場合
// セクションが収束している場合、tableViewにreloadは行わない

// 削除の場合
// セクションが収束している場合、tableViewにdeleteは行わない

// 移動の場合
// - 移動元セクションが収束している、移動先セクションが収束していない場合
// moveRowは使わない。移動先セクションに対してinsertを行う
// - 移動元セクションが収束していない、移動先セクションが収束している場合
// moveRowは使わない。移動元セクションに対してdeleteを行う
// - 移動元/移動先共に収束している
// tableViewに対する操作は行わない
