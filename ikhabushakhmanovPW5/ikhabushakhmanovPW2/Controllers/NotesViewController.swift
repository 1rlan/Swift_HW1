//
//  NotesViewController.swift
//  ikhabushakhmanovPW3
//
//  Created by Ирлан Абушахманов on 14.11.2022.
//

import UIKit

final class NotesViewController: UIViewController, UITableViewDelegate {
    
    public let tableView = UITableView(frame: .zero, style: .insetGrouped)
    public var dataSource = [ShortNote]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    private func setupTableView() {
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view, [.left : 0, .top : 0, .bottom : 0, .right : 0])
        tableView.allowsFocus = true
    }
    
    public func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    private func setupNavBar() {
        self.title = "Notes"
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    @objc
    func dismissViewController() {
        dismiss(animated: true)
    }
}


