//
//  Job.swift
//  MyScheduler
//
//  Created by Yusuf Kamil AK on 11/30/17.
//  Copyright © 2017 Yusuf Kamil AK. All rights reserved.
//

import Foundation

class Job: NSObject {
    
    var title: String?
    var estimationTimeInHours: Double?
    var completionPercentage = 0.0
    var priority: Double?
    var dueDate: Date?
    var totalTimeSpent = 0.0
    var timeToSpendInNextPeriod: Double?
    var jobDescription: String?
    var uniquePriority: Double?
    
    @discardableResult func setUniquePriority() -> Double {
        guard let dueDate = dueDate,let priority = priority,let estimation = estimationTimeInHours else { return -1 }
        let interval:TimeInterval = dueDate.timeIntervalSinceNow
        let intervalInHours = Double((interval / 60) / 24)
        return Double(estimation / intervalInHours) * priority
    }
    
    func updateValues() {
        // Completion Percentage
        guard let est = estimationTimeInHours else { return }
        self.completionPercentage = (totalTimeSpent / est)*100
    }
}
