//
//  TableViewController.swift
//  testWithAPI
//
//  Created by 15k on 30.03.18.
//  Copyright © 2018 15k. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var getTextFromRequest = ""
    var charactersDict = [Character : Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersDict = self.getTextFromRequest.characters.reduce([:]) {
            (dic,char) -> Dictionary<Character,Int> in
            var dict = dic
            let i = dict[char] ?? 0
            dict[char] = i + 1
            return dict
        }
        print(self.getTextFromRequest)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersDict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell {
            if Array(charactersDict.keys)[indexPath.row] == " " {
                cell.letterLabel.text = "space"
                cell.countLabel.text = String(Array(charactersDict.values)[indexPath.row])
            } else {
                cell.letterLabel.text = String(Array(charactersDict.keys)[indexPath.row])
                cell.countLabel.text = String(Array(charactersDict.values)[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
 
}
