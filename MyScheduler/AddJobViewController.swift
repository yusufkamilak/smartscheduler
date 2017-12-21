//
//  AddJobViewController.swift
//  MyScheduler
//
//  Created by Yusuf Kamil AK on 11/30/17.
//  Copyright © 2017 Yusuf Kamil AK. All rights reserved.
//

import Cocoa

class AddJobViewController: NSViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var estimatedTimeTextField: NSTextField!
    @IBOutlet weak var priorityPopUpButton: NSPopUpButton!
    @IBOutlet weak var dueDatePicker: NSDatePicker!
    @IBOutlet weak var descriptionTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addJobTapped(_ sender: Any) {
        JobOrganiser.shared.arrangeJobs(newJob: createJob())
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.dismiss(self)
    }
    
    fileprivate func createJob() -> Job {
        let job = Job()
        job.title = titleTextField.stringValue
        job.estimationTimeInHours = Double(estimatedTimeTextField.stringValue)
        job.priority = Double(priorityPopUpButton.indexOfSelectedItem)
        job.dueDate = dueDatePicker.dateValue
        job.jobDescription = descriptionTextField.stringValue
        job.uniquePriority = job.setUniquePriority()
        job.updateValues()
        return job
    }
    
}
