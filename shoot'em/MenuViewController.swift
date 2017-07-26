//
//  MenuViewController.swift
//  shoot'em
//
//  Created by Théo Bequet on 26/07/2017.
//  Copyright © 2017 etna. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var difficultyPicker: UIPickerView!
    let difficulties = ["Easy", "Medium", "Hard"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        difficultyPicker.dataSource = self
        difficultyPicker.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MenuToGame") {
            let vc = segue.destination as! GameViewController
            vc.difficulty = difficultyPicker.selectedRow(inComponent: 0)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulties[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return print("item selectionne \(difficulties[row])")
    }
}
