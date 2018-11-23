//
//  SampleTableViewController.swift
//  GenericsTableDemo
//
//  Created by De La Cruz, Eduardo on 23/11/2018.
//  Copyright © 2018 De La Cruz, Eduardo. All rights reserved.
//

import UIKit

// Generic C for Cell and M for Model

class BaseTableViewController<C: BaseCell<M>, M>: UITableViewController {
    
    let cellId = "cellId"
    var items = [M]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(C.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseCell<M>
        cell.item = items[indexPath.row]
        return cell
    }
}

class BaseCell<U>: UITableViewCell {
    var item: U!
}

struct Dog {
    let name: String
}

class DogCell: BaseCell<Dog> {
    override var item: Dog! {
        didSet {
            textLabel?.text = item.name
        }
    }
}

class StringCell: BaseCell<String> {
    override var item: String! {
        didSet {
            textLabel?.text = item
        }
    }
}

class DummyController: BaseTableViewController<StringCell, String> {
    
}

class SomeListController: BaseTableViewController<DogCell, Dog> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            Dog(name: "Woof Woof"),
            Dog(name: "Ruff Ruff Ruff")
        ]
    }
}
