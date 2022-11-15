//
//  NotesViewController Extension.swift
//  ikhabushakhmanovPW3
//
//  Created by Ирлан Абушахманов on 15.11.2022.
//

import UIKit

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
}


extension NotesViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->                                                                                                UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: .none)
        { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


extension NotesViewController {
    func saveData() {
        if let url = Bundle.main.url(forResource: "Notes", withExtension: "json") {
            do {
                try Data((String(data: (try JSONEncoder().encode(dataSource)), encoding: .utf8)!).utf8).write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadData() {
        if let url = Bundle.main.url(forResource: "Notes", withExtension: "json") {
            do {
                dataSource = try JSONDecoder().decode([ShortNote].self, from: (try Data(contentsOf: url)))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
