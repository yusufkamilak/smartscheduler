//
//  ViewController.swift
//  MyScheduler
//
//  Created by Yusuf Kamil AK on 11/30/17.
//  Copyright © 2017 Yusuf Kamil AK. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "JobOrganiser"
    }
}

extension MainViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    fileprivate enum CellIdentifier {
        static let jobCellID = "jobCell"
        static let completionCellID = "completionCell"
        static let timeToSpendInNextPeriodCellID = "timeCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return JobOrganiser.shared.jobs?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let jobs = JobOrganiser.shared.jobs else { return nil }
        if row >= jobs.count { return nil }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifier.jobCellID), owner: nil) as? NSTableCellView {
            switch tableColumn {
            case tableView.tableColumns[0]?:
                if let title = jobs[row].title {
                    cell.textField?.stringValue = title
                }
                cell.imageView?.isHidden = false
            case tableView.tableColumns[1]?:
                cell.textField?.stringValue = "\(jobs[row].completionPercentage)%"
            case tableView.tableColumns[2]?:
                cell.textField?.stringValue = "\(jobs[row].timeToSpendInNextPeriod ?? 0.0)h"
            case tableView.tableColumns[3]?:
                if let time = jobs[row].dueDate?.description {
                    cell.textField?.stringValue = "\(time)"
                }
            case tableView.tableColumns[4]?:
                if let est = jobs[row].estimationTimeInHours {
                    cell.textField?.stringValue = "\(Double(((est - jobs[row].totalTimeSpent)*100)/100))h"
                }
            default:
                if let desc = jobs[row].jobDescription {
                    cell.textField?.stringValue = "\(desc)"
                }
            }
            return cell
        }
        return nil
    }
    
    @objc func reloadList() {
        tableView.reloadData()
    }
}
