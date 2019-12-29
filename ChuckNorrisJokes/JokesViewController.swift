//
//  JokesViewController.swift
//  ChuckNorrisJokes
//
//  Created by Andrei Kucherenko on 28.12.2019.
//  Copyright © 2019 Andrei Kucherenko. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController {
    
    let jokesURL = "http://api.icndb.com/jokes/random/"
    var jokesNumber = 20
    var jokes = ["Joke 1", "Joke 1", "Joke 1"]
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "JokeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: JokeCell.reusableId)
    }
    
}

extension JokesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeCell.reusableId, for: indexPath ) as! JokeCell
        let joke = jokes[indexPath.row]
        cell.setData(joke: joke)
        
        return cell
    }
    
}

