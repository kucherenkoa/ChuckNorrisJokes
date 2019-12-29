//
//  JokeCell.swift
//  ChuckNorrisJokes
//
//  Created by Andrei Kucherenko on 29.12.2019.
//  Copyright © 2019 Andrei Kucherenko. All rights reserved.
//

import UIKit

class JokeCell: UITableViewCell {
    
    static let reusableId = "JokeCell"
    
    @IBOutlet weak var jokeText: UILabel!
    
    func setData(joke: String){
        jokeText.text = joke
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
