//
//  BackGroundTaskService.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/17/20.
//

import Foundation
import BackgroundTasks
import RxSwift

class BackGroundTaskService {
   private let viewModel = AppManager.shared.getContentViewViewModel()
   private let disposeBag = DisposeBag()
    static let shared = BackGroundTaskService()
    // Mark :-  Register BackGround Tasks
    func registerBackgroundTask() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: AppConstString.bgTaskId.rawValue,
                                        using: nil) { task in
            
            //This task is cast with processing request (BGProcessingTask)
            task.expirationHandler = {
                task.setTaskCompleted(success: false)
            }
            
            self.viewModel.viewState.subscribe(onNext: { viewState in
                switch viewState {
                default: task.setTaskCompleted(success: true)
                }
            }).disposed(by: self.disposeBag)
            
            self.viewModel.fetchCovidStatistics()
            self.scheduleGetCovidStatistics()
        }
    }
    
    func scheduleGetCovidStatistics() {
        let request = BGProcessingTaskRequest(identifier: AppConstString.bgTaskId.rawValue)
        request.requiresNetworkConnectivity = true //Need to true if ur task need to network process.Defaults to false.
        request.requiresExternalPower = false
        //If we keep requiredExternalPower = true then it required device is connected to external power.
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 10 * 60) // fetch Image Count after 10 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch (let error) {
            print("Could not schedule GetCovidStatistics: \(error.localizedDescription)")
        }
    }
}
