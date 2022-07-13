//
//  StopwatchViewController.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: StopwatchViewModelProtocol
    var stopwatchView: StopwatchView
    
    
    // MARK: - Init
    
    init(viewModel: StopwatchViewModelProtocol = StopwatchViewModel()) {
        self.viewModel = viewModel
        self.stopwatchView = StopwatchView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    @objc
    func startButtonClick () {
        if !viewModel.isRunning {
            
            stopwatchView.startButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            stopwatchView.resetButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            stopwatchView.pauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            
            if stopwatchView.timerPickerView.isHidden == true {
                
                viewModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stopwatchRun), userInfo: nil, repeats: true)
                viewModel.isRunning = true
            }
            
            if !stopwatchView.timerPickerView.isHidden {
                timerRun()
                viewModel.isRunning = true
            }
        }
    }
    
    @objc
    func pauseButtonClick () {
        viewModel.timer.invalidate()
        stopwatchView.startButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        stopwatchView.pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        viewModel.isRunning = false
    }
    
    @objc
    func resetButtonClick () {
        viewModel.timer.invalidate()
        viewModel.isRunning = false
        viewModel.counter = 0
        stopwatchView.pauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        stopwatchView.startButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        stopwatchView.timeLabel.text = "00:00:00"
    }
    
    @objc
    func changeView () {
        switch stopwatchView.segmentedControl.selectedSegmentIndex {
        case 0:
            stopwatchView.startButton.isSelected = false
            stopwatchView.stopWatchImageView.image = UIImage(systemName: "stopwatch")
            stopwatchView.timerPickerView.isHidden = true
        default:
            stopwatchView.stopWatchImageView.image = UIImage(systemName: "timer")
            stopwatchView.timerPickerView.isHidden = false
        }
    }
    
    @objc
    func stopwatchRun () {
        viewModel.counter += 1
        stopwatchView.timeLabel.text = viewModel.getTime(hour: viewModel.hours, minute: viewModel.minutes, second: viewModel.seconds)
    }
    
    @objc
    func timerRun () {
        viewModel.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            
            self.viewModel.timerRun()
            self.stopwatchView.timeLabel.text = String(format:"%02i:%02i:%02i", self.viewModel.hours, self.viewModel.minutes, self.viewModel.seconds)
        }
    }
    
    
    // MARK: - ConfigureUI
    
    fileprivate func configureUI () {
        view.addSubview(stopwatchView)
        title = "Clock"
        stopwatchView.timerPickerView.dataSource = self
        stopwatchView.timerPickerView.delegate = self
        setConstraints()
        addObservableTarget()
    }
    
    fileprivate func setConstraints () {
        let constraints = [
            stopwatchView.topAnchor.constraint(equalTo: view.topAnchor),
            stopwatchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stopwatchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stopwatchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func addObservableTarget () {
        stopwatchView.startButton.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        stopwatchView.resetButton.addTarget(self, action: #selector (resetButtonClick), for: .touchUpInside)
        stopwatchView.pauseButton.addTarget(self, action: #selector(pauseButtonClick), for: .touchUpInside)
        stopwatchView.segmentedControl.addTarget(self, action: #selector(changeView), for: .valueChanged)
    }
}


    // MARK: - UIPickerViewDataSource
extension StopwatchViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        default:
            return 60
        }
    }
}


    // MARK: - UIPickerViewDelegate
extension StopwatchViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%0d", row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setRow(component: component, row: row)
    }
}

