//
//  WelcomeViewController.swift
//  ikhabushakhmanovPW2
//
//  Created by Ирлан Абушахманов on 29.09.2022.
//

import UIKit

final class WelcomeViewController: UIViewController, ObserverProtocol {
    
    func changeState(_ color: UIColor) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = color
        }
    }
    

    private let incrementButton = UIButton()
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let commentView = UIView()
    private var buttonsSV = UIStackView()
    private var colorPaletteView = ColorPaletteView()
    private var value: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    public func setupView() {
        view.backgroundColor = .systemGray6
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
        
        colorPaletteView.delegate = self
    }
    
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.setHeight(48)
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow(bottomMargin: 8)
        
        self.view.addSubview(incrementButton)
        
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view)
    }
    
    
    @discardableResult
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0,  weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom: 16, .right: 16])
        commentLabel.text = "Заводим моторчик..."
        return commentView
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "Стартуем"
        case 10...20:
            commentLabel.text = "Гоним"
        case 20...30:
            commentLabel.text = "Вперед"
        case 30...40:
            commentLabel.text = "Ага ага"
        case 40...50:
            commentLabel.text = "Стабильно идем"
        case 50...60:
            commentLabel.text = "Давай давай"
        case 60...70:
            commentLabel.text = "Достойно"
        case 70...80:
            commentLabel.text = "Высший пилотаж"
        case 80...90:
            commentLabel.text = "Огонь!!!"
        case 90...100:
            commentLabel.text = "К Р А С U B O"
        default:
            commentLabel.text = "Finish!"
            break
        }
    }
    
    
    @IBAction
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        self.updateUI()
    }
    
    
    
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "🖊")
        let newsButton = makeMenuButton(title: "📰")
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
        
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(showNotes), for: .touchUpInside)
        newsButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
    }
    
    
    @objc
    private func showNotes() {
        navigationController?.pushViewController(NotesViewController(), animated: true)
    }
    
    @objc
    private func showNews() {
        navigationController?.pushViewController(NewsListViewController(), animated: true)
    }
    
    
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.updateSlidersValue(view.backgroundColor ?? .white)
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    func updateUI() {
        self.valueLabel.text = "\(self.value)"
        UIView.transition(with: commentLabel, duration: 0.75, options: .transitionFlipFromBottom, animations: {
            self.updateCommentLabel(value: self.value)
        })
    
    }
    
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -8)
        ])
    }
}
