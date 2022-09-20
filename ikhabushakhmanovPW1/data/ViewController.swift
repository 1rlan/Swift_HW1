//
//  ViewController.swift
//  ikhabushakhmanovPW1
//
//  Created by Ирлан Абушахманов on 20.09.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var views: [UIView] = []
    var set = Set<UIColor>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        while set.count < views.count {
            set.insert(UIColor(hexString: UIColor.hexGenerator()))
        }
        changeViews(sender)
    }
    
    func changeViews(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        UIView.animate(withDuration: 1,
                       animations: {
            for view in self.views {
                view.layer.cornerRadius = 10
                view.backgroundColor = self.set.popFirst()
            }
        }) { completion in
            button?.isEnabled = true
        }
        self.set.removeAll();
    }
}

