//
//  StopwatchView.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import UIKit

class StopwatchView: UIView {
    
    
    // MARK: - Views
    
    let stopWatchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage (systemName: "stopwatch")
        imageView.tintColor = .black
        
        imageView.frame = .init(x: 0, y: 0, width: 50, height: 50)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Stopwatch", "Timer"]
        let sControl = UISegmentedControl(items: items)
        sControl.translatesAutoresizingMaskIntoConstraints = false
        return sControl
    } ()
    
    let timeLabel: UILabel = {
        let label = UILabel ()
        label.text = "00:00:00"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let pauseButton: UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        button.tintColor = .black
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    } ()
    
    let resetButton: UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        button.tintColor = .black
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let startButton: UIButton = {
        let button = UIButton ()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = .black
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    let timerPickerView: UIPickerView = {
        let pickerView = UIPickerView ()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    } ()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Congigure
    
    private func configureUI() {
        
        backgroundColor = .systemYellow
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        
        addSubview(stopWatchImageView)
        addSubview(segmentedControl)
        addSubview(timeLabel)
        addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(resetButton)
        buttonsStackView.addArrangedSubview(pauseButton)
        buttonsStackView.addArrangedSubview(startButton)
        
        addSubview(buttonsStackView)
        addSubview(timerPickerView)
        timerPickerView.isHidden = true
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func setConstraints() {
        let constraints = [
            
            stopWatchImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stopWatchImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stopWatchImageView.widthAnchor.constraint(equalToConstant: 50),
            stopWatchImageView.heightAnchor.constraint(equalToConstant: 50),
            
            segmentedControl.topAnchor.constraint(equalTo: stopWatchImageView.bottomAnchor, constant: 13),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 164),
            segmentedControl.heightAnchor.constraint(equalToConstant: 28),
            
            timeLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            timerPickerView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -50),
            timerPickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            timerPickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
