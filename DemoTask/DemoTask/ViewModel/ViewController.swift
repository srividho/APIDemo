//
//  ViewController.swift
//  DemoTask
//
//  Created by Sri on 17/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var datas = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        downloadJSON {
            self.userTableView.reloadData()
        }
    }
    
    func downloadJSON(completed: @escaping() -> ()) {
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    self.datas = try JSONDecoder().decode([UserData].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch { print("JSON Error") }
            }
        }.resume()
    }
    
}

/* Delegate & Datasource methods */

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    /* delegate method */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailsViewController {
            destination.userdetail = datas[(userTableView.indexPathForSelectedRow?.row)!]
       }
    }
    
    /* datasource methods */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = datas[indexPath.row].localized_name.capitalized
        return cell
    }
}


