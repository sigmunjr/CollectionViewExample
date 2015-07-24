//
//  ViewController.swift
//  CollectionView
//
//  Created by Sigmund Rolfsjord on 22.07.15.
//  Copyright (c) 2015 Sigmund Rolfsjord. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView?
    var selectedCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self

        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView!.registerClass(ExtendedInfoCell.self, forCellWithReuseIdentifier: "ExtendedInfoCell")
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfCells = 7;
        return numberOfCells + (numberOfCells+1)/2
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCellIndexPath = indexPath
        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        
        let numberOfCellsInSection = collectionView.numberOfItemsInSection(indexPath.section)
        let add = 2-((indexPath.row)%3)
        let closestInfoCellIndex = min(indexPath.row + add, numberOfCellsInSection-1)
        
        let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: closestInfoCellIndex, inSection: indexPath.section)) as! ExtendedInfoCell
        
        //Get cell collapsed height
        cell.contentView.frame = CGRect(origin:cell.frame.origin, size:CGSize(width: cell.frame.width, height: 10.0))
        
        let resizeCell = {
            //Get cell expanded height
            cell.contentView.frame = CGRect(origin:cell.frame.origin, size:CGSize(width: cell.frame.width, height: 100.0))
        }
        
        UIView.transitionWithView(collectionView, duration: 0.3, options: UIViewAnimationOptions.AllowAnimatedContent, animations: resizeCell, completion: { (fininshed: Bool) -> () in
                
        });
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        var retCell: UICollectionViewCell;
        var itemsInSection = collectionView.numberOfItemsInSection(indexPath.section);
        if (isIndexPathAInfoCell(indexPath)) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ExtendedInfoCell", forIndexPath: indexPath) as! ExtendedInfoCell
            cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
            retCell = cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
            cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
            retCell = cell
        }
        return retCell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            if (isIndexPathAInfoCell(indexPath)) {
                let distanceFromSelected = selectedCellIndexPath.row - indexPath.row
                if (selectedCellIndexPath.section == indexPath.section && distanceFromSelected<0 && distanceFromSelected > -3)
                {
                    //Get cell expanded height
                    return CGSize(width: view.frame.width, height: 100)
                }
                //Get cell collapsed height
                return CGSize(width: view.frame.width, height: 10)
            } else {
                //Get cell expanded height
                return CGSize(width: view.frame.width/2-5, height: 100)

            }
    }
    
    private func isIndexPathAInfoCell(indexPath: NSIndexPath) -> Bool {
        var nrOfItems = collectionView!.numberOfItemsInSection(indexPath.section);
        return (indexPath.row+1) % 3 == 0 || indexPath.row+1 == nrOfItems
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

