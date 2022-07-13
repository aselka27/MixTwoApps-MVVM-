//
//  TaskViewController.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import UIKit

class TaskViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private var viewModel: TaskViewModelProtocol
    
    
    
    
    // MARK: - Views
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте новую задачу нажав на кнопку плюс."
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var editButton: UIButton = {
        
        let button = UIButton()
        let imageButton = UIImage(systemName: "pencil.circle.fill")
        button.setImage(imageButton, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private var plusButton: UIButton = {
        
        let button = UIButton()
        let imageButton = UIImage(systemName: "plus.circle.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50), forImageIn: .normal)
        button.setImage(imageButton, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    init(viewModel: TaskViewModelProtocol = TaskViewModel()){
        self.viewModel = viewModel
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
    fileprivate func onEditButton(){
        tableView.isEditing.toggle()
        plusButton.isHidden.toggle()
        tableView.isEditing ? editButton.setImage(UIImage(systemName: "xmark.circle.fill"), for:.normal) : editButton.setImage(UIImage(systemName: "pencil.circle.fill"), for:.normal)
        
    }
    @objc
    fileprivate func onPlusButton(){
        let vc = DetailViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Configure UI
    
    fileprivate func configureUI() {
        view.backgroundColor = .white
        title = "ToDo"
        navigationItem.title = "Задачи"
        
        view.addSubview(tableView)
        view.addSubview(textLabel)
        view.addSubview(editButton)
        view.addSubview(plusButton)
        
        tableView.rowHeight = 70
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setConstraints()
        addObservableTarget()
    }
    
    fileprivate func setConstraints(){
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            
            editButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor, constant: -15),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 50),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    fileprivate func addObservableTarget(){
        editButton.addTarget(self, action: #selector(onEditButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(onPlusButton), for: .touchUpInside)
    }
}


// MARK: - UITableViewDataSource

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.task.count == 0 {
            textLabel.isHidden = false
            return 0
        } else {
            textLabel.isHidden = true
            return viewModel.task.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        let tasks = viewModel.task[indexPath.row]
        cell.configure(title: tasks.taskName,
                       subtitle: tasks.taskDescription,
                       isChecked: tasks.isClicked)
        return cell
    }
}
// MARK: - UITableViewDelegate

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell: TaskTableViewCell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
        let item = viewModel.task[indexPath.row]
        item.isClicked.toggle()
        cell.checkCell(bool: item.isClicked)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        
        let vc = DetailViewController()
        vc.viewModel.task = viewModel.task[indexPath.row]
        vc.viewModel.descText = viewModel.task[indexPath.row].taskDescription
        vc.descriptionTextView.textColor = UIColor.black
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = viewModel.task[sourceIndexPath.row]
        viewModel.task.remove(at: sourceIndexPath.row)
        viewModel.task.insert(item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.task.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else if  editingStyle == .insert {
            let rowIndex = viewModel.task.count - 1
            let indexPath = IndexPath(row: rowIndex, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

// MARK: - DetailViewControllerDelegate
extension TaskViewController: DetailViewControllerDelegate {
    func detailVC(controller: DetailViewController, added item: TaskModel) {
        viewModel.task.append(TaskModel(taskName: item.taskName, taskDescription: item.taskDescription, isClicked: false))
        let rowIndex = viewModel.task.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func detailVC(controller: DetailViewController, edited item: TaskModel) {
        if let index = viewModel.task.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell{
                cell.configure(title: item.taskName, subtitle: item.taskDescription, isChecked: item.isClicked)
            }
        }
    }
}
