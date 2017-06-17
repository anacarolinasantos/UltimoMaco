//
//  ProfileMotivationTableViewController.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ProfileMotivationTableViewController: UITableViewController {
    
    //MARK: - Atributes
    var motivations: [Motivation]?
    var newMotivationViewController: NewMotivationTableViewController?
    var timer = Timer()
    
    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        do {
            // Verify if Motivations exists, and gets it
            if let motivations = (try DatabaseController.persistentContainer.viewContext.fetch(Motivation.fetchRequest()) as? [Motivation]) {
                
                if motivations.count != 0 {
                    self.motivations = motivations
                }
            }
        } catch _ as NSError {
            print("Error")
        }
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // update tableview content
    override func viewWillAppear(_ animated: Bool) {
        do {
            // Verify if Motivations exists, and gets it
            if let motivations = (try DatabaseController.persistentContainer.viewContext.fetch(Motivation.fetchRequest()) as? [Motivation]) {
                
                if motivations.count != 0 {
                    self.motivations = motivations
                }
            }
        } catch _ as NSError {
            print("Error")
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let motivationsSize = motivations?.count {
            return motivationsSize
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let motivation = motivations?[indexPath.row]
        
        //If there is a description, then the cell is thinner
        if motivation?.title == "" {
            return 192
        } else {
            return 96
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Configure the cell depending on which information motivantions has
        let motivation = motivations?[indexPath.row]

        //Verify if there is an image on this motivation and a description, and then make the first type of motivations cells
        if let motivationImage = motivation?.getImageAsMedia() {
            if motivation?.desMotivation != nil && motivation?.desMotivation != "" {
                let firstCell = tableView.dequeueReusableCell(withIdentifier: "firstCustomCell", for: indexPath) as! MotivationTypeOneTableViewCell
                
                firstCell.titleLabel?.text = motivation?.title
                firstCell.descriptionLabel?.text = motivation?.desMotivation
                firstCell.motivationImage?.image = motivationImage
                
                return firstCell
            }
            //If it doesn't have a description, then make the second type of cells
            let secondCell = tableView.dequeueReusableCell(withIdentifier: "secondCustomCell", for: indexPath) as! MotivationTypeTwoTableViewCell
            
            secondCell.motivationLargeImage.image = motivationImage
            
            return secondCell
            
        }
        
        //If it doesn't have an image, then make the third type of cells
        let thirdCell = tableView.dequeueReusableCell(withIdentifier: "thirdCustomCell", for: indexPath) as! MotivationTypeThreeTableViewCell
        
        thirdCell.titleLabel?.text = motivation?.title
        thirdCell.descriptionLabel?.text = motivation?.desMotivation
        
        return thirdCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newMotivationViewController = self.storyboard?.instantiateViewController(withIdentifier: "newMotivation") as? NewMotivationTableViewController
        
        let navigationController = UINavigationController(rootViewController: newMotivationViewController!)
        
        newMotivationViewController?.motivation = motivations?[indexPath.row]
        
        self.present(navigationController, animated: true, completion: nil)
    }

    //MARK: - Actions
    @IBAction func addNewMotivation(_ sender: UIBarButtonItem) {
        newMotivationViewController = self.storyboard?.instantiateViewController(withIdentifier: "newMotivation") as? NewMotivationTableViewController
        
        let navigationController = UINavigationController(rootViewController: newMotivationViewController!)
        
        self.present(navigationController, animated: true, completion: nil)
    }
}
