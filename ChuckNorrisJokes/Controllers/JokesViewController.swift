//
//  JokesViewController.swift
//  ChuckNorrisJokes
//
//  Created by Andrei Kucherenko on 28.12.2019.
//  Copyright © 2019 Andrei Kucherenko. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController {
    
    let networkService = NetworkService()
    var jokes: [JokeModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var jokesNumberOutlet: UITextField!
    
    @IBAction func loadButtonAction(_ sender: UIButton) {
        jokesNumberOutlet.resignFirstResponder()
        loadJokes()
    }
    
    @IBAction func jokesNumberActionLoad(_ sender: Any) {
        jokesNumberOutlet.resignFirstResponder()
        loadJokes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTextField()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "JokeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: JokeCell.reusableId)
    }
    
    // MARK: - Setup TextField
    func setupTextField() {
        let customBorderColor = UIColor.systemBlue
        jokesNumberOutlet.layer.borderColor = customBorderColor.cgColor
        jokesNumberOutlet.layer.borderWidth = 1
        jokesNumberOutlet.placeholder = "Enter number of jokes"
        jokesNumberOutlet.delegate = self
        jokesNumberOutlet.keyboardType = .decimalPad
    }
    
    // MARK: - Keyboard actions
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: Call jokes download
    func loadJokes () {
        var jokesNumbersToLoad = 0
        print("Load Initiate")
        if let jokesNumbers = Int(jokesNumberOutlet.text!) {
            jokesNumbersToLoad = jokesNumbers
        }
        print("Requested \(jokesNumbersToLoad) jokes")
        
        if jokesNumbersToLoad > 0 {
            networkService.fetchJokes(jokesNumbers: jokesNumbersToLoad) { [weak self] (downloadedJokes) in
                self?.jokes = downloadedJokes?.value ?? []
                self?.tableView.reloadData()
            }
        } else {
            self.jokes = []
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
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

// MARK: - UITextFieldDelegate
extension JokesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == jokesNumberOutlet {
            textField.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
}

