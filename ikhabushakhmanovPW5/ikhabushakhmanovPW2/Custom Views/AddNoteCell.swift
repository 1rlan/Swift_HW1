//
//  AddNoteCell.swift
//  ikhabushakhmanovPW3
//
//  Created by Ирлан Абушахманов on 14.11.2022.
//

import UIKit
final class AddNoteCell: UITableViewCell, UITextViewDelegate{
    var delegate = NotesViewController()
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupTextView()
        setupButton()
        setupStack()
    }

    func setupTextView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.delegate = self
        textView.textColor = .lightGray
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        textView.text = "Ты можешь поделиться со мной мыслями..."
    }
    
    func setupButton() {
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.isEnabled = true
        addButton.alpha = 0.5
    }
    
    func setupStack() {
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textView.textColor == UIColor.lightGray {
            self.textView.text = ""
            self.textView.textColor = UIColor.black
        }
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if (textView.text != "" && textView.textColor == UIColor.black) {
            delegate.newNoteAdded(note: ShortNote(text: textView.text))
            textView.text = ""
        }
    }
}
