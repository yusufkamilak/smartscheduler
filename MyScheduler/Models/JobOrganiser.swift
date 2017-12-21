//
//  JobOrganiser.swift
//  MyScheduler
//
//  Created by Yusuf Kamil AK on 11/30/17.
//  Copyright © 2017 Yusuf Kamil AK. All rights reserved.
//

import Foundation

class JobOrganiser: NSObject {
    
    static let shared = JobOrganiser()
    
    private override init() {}
    
    var jobs: [Job]? = []
    
    func arrangeJobs(newJob: Job? = nil) {
        guard var jobs = jobs else { return }
        if let newJob = newJob {
            jobs.append(newJob)
            if let uniquePriority = newJob.uniquePriority {
                print("New job is added with a unique priority  \(uniquePriority)")
            }
        }
        self.jobs = jobs.sorted(by: { guard let first = $0.uniquePriority,let second = $1.uniquePriority else { return false }; return first > second })
    }
    
}
