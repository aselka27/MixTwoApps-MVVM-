//
//  TaskTableViewCell.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    
    // MARK: - Property
    
    static let identifier = "Taskcell"
    
    
    // MARK: - Views
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 25), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - ConfigureUI
    
    fileprivate func configureUI() {
        contentView.addSubview(checkButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        accessoryType = .detailDisclosureButton
        setConstraints()
    }
    
    fileprivate func setConstraints() {
        let constraints = [
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkButton.widthAnchor.constraint(equalToConstant: 25),
            checkButton.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    // MARK: - Interection
    
    public func configure(title: String, subtitle: String, isChecked: Bool) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        checkCell(bool: isChecked)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        subtitleLabel.text = nil
        checkButton.setImage(nil, for: .normal)
    }
    
    // MARK: - Helepers
    
    func checkCell(bool: Bool) {
        checkButton.setImage(UIImage(systemName: bool ? "checkmark.circle" :
                                        "circle")?.withTintColor(.orange, renderingMode: .alwaysOriginal), for: .normal)
    }
}
