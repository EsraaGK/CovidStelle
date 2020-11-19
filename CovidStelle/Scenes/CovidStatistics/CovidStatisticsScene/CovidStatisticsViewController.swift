//
//  CovidStatisticsViewController.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/17/20.
//

import UIKit
import RxSwift
import RxCocoa

class CovidStatisticsViewController: UIViewController {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: CovidStatisticsViewModel
    
    // MARK: - IBOutlets
    @IBOutlet private weak var firstCommanInstructionLabel: UILabel!
    @IBOutlet private weak var secondCommanInstructionLabel: UILabel!
    @IBOutlet private weak var thirdCommanInstructionLabel: UILabel!
    @IBOutlet private weak var forthCommanInstructionLabel: UILabel!
    @IBOutlet private weak var firstStateInstructionLabel: UILabel!
    @IBOutlet private weak var secondStateInstructionLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var dataView: UIView!
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    init(viewModelFactory: ContentViewViewModelFactory) {
        self.viewModel = viewModelFactory.getContentViewViewModel()
        super.init(nibName: nil, bundle: nil)
        observeOnViewStates()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewModel.viewLoaded()
        self.dataView.isHidden = true
        self.statusImageView.isHidden = true
        bindStatusLabel()
        setCommonInstructions()
    }
    
    private func observeOnViewStates() {
        viewModel.viewState.subscribe(onNext: { state in
            switch state {
            case .error(let message):
                self.showErrorState()
                print(message ?? "")
            case .data:
                self.showDataState()
            case .loading:
                self.showLoadingState()
            case .noInternet:
                self.showNoInternetState()
            case .requestLocationPermission:
                self.requestAuthorization()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setCommonInstructions() {
        firstCommanInstructionLabel.text = NSLocalizedString(LocalizationStringKeys.commanInstructions1.rawValue,
                                                             comment: "")
        
        secondCommanInstructionLabel.text = NSLocalizedString(LocalizationStringKeys.commanInstructions2.rawValue,
                                                              comment: "")
        thirdCommanInstructionLabel.text = NSLocalizedString(LocalizationStringKeys.commanInstructions3.rawValue,
                                                             comment: "")
        forthCommanInstructionLabel.text = NSLocalizedString(LocalizationStringKeys.commanInstructions4.rawValue,
                                                             comment: "")
    }
    
    private func bindStatusLabel() {
        viewModel.statusLabel.bind(to: statusLabel.rx.text).disposed(by: disposeBag)
        viewModel.statusColor.bind(to: colorView.rx.backgroundColor).disposed(by: disposeBag)
        viewModel.firstInstructionLabel.bind(to: firstStateInstructionLabel.rx.text).disposed(by: disposeBag)
        viewModel.secondInstructionLabel.bind(to: secondStateInstructionLabel.rx.text).disposed(by: disposeBag)
    }
    
    private func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    private func showNoInternetState() {
        self.stopActivityIndicator()
        self.dataView.isHidden = true
        self.statusImageView.isHidden = false
        self.statusImageView.image = #imageLiteral(resourceName: "no_internet")
           // UIImage(named: "no_internet")
    }
    
    private func showDataState() {
        self.stopActivityIndicator()
        self.dataView.isHidden = false
        self.statusImageView.isHidden = true
    }
    
    private func showLoadingState() {
        self.startActivityIndicator()
        self.dataView.isHidden = true
        self.statusImageView.isHidden = true
    }
    
    private func showErrorState() {
        self.stopActivityIndicator()
        self.dataView.isHidden = true
        self.statusImageView.isHidden = false
        self.statusImageView.image = #imageLiteral(resourceName: "error")
           // UIImage(named: "error")
    }
    
    private func requestAuthorization() {
        // initialise a pop up for using later
        let alertController = UIAlertController(
            title: NSLocalizedString(LocalizationStringKeys.locationPermissions.rawValue, comment: ""),
            message: NSLocalizedString(LocalizationStringKeys.locationPermissionsMessage.rawValue, comment: ""),
            preferredStyle: .alert)
        let settingsAction = UIAlertAction(
            title: NSLocalizedString(LocalizationStringKeys.settings.rawValue, comment: ""),
            style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(
            title: NSLocalizedString(LocalizationStringKeys.cancel.rawValue, comment: ""),
            style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
