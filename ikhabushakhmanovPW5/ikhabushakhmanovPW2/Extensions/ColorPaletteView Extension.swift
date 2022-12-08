//
//  ColorPaletteView Extension.swift
//  ikhabushakhmanovPW3
//
//  Created by Ирлан Абушахманов on 24.10.2022.
//

import UIKit

extension ColorPaletteView {
    
    final class ColorSliderView : UIControl {
        
        public let slider = UISlider()
        private let colorLabel = UILabel()
        
        var value : Float {
            get {
                slider.value
            } set {
                slider.value = newValue
            }
        }
        
        init(colorName : String, value : Float) {
            super.init(frame: .zero)
            colorLabel.text = colorName
            slider.value = value
            setupView()
            slider.addTarget(self, action: #selector(sliderMoved(_ :)) , for: .touchUpInside)
            self.value = value
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            addSubview(stackView)
            stackView.pin(to: self, [.left: 12, .top: 12, .right: 12, .bottom: 12])
        }
        
        @objc
        func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
