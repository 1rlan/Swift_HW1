//
//  ColorPaletteView.swift
//  ikhabushakhmanovPW3
//
//  Created by Ирлан Абушахманов on 24.10.2022.
//

import UIKit

final class ColorPaletteView: UIControl {
    
    var delegate : ObserverProtocol?
    
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6


    
    
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let components = chosenColor.getComponents()
        
        let redControl = ColorSliderView(colorName: "Red", value: Float(components[0]))
        let greenControl = ColorSliderView(colorName: "Green", value: Float(components[1]))
        let blueControl = ColorSliderView(colorName: "Blue", value: Float(components[2]))
        
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        
        [redControl, greenControl, blueControl].forEach {
            stackView.addArrangedSubview($0)
            $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
            
    }
    @objc
    func sliderMoved(slider : ColorSliderView) {
        let components = chosenColor.getComponents()
        switch slider.tag {
        case 0:
            chosenColor = UIColor(red: CGFloat(slider.value), green: components[1], blue: components[2], alpha: 1)
        case 1:
            chosenColor = UIColor(red: components[0], green:  CGFloat(slider.value), blue: components[2], alpha: 1)
        default:
            chosenColor = UIColor(red: components[0], green: components[1], blue:  CGFloat(slider.value), alpha: 1)
        }
        sendActions(for: .touchDragInside)
        delegate?.changeState(chosenColor)
    }
}
