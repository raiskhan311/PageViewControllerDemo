//
//  PageVC.swift
//  PageViewControllerDemo
//
//  Created by mac on 13/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var VCArray: [UIViewController] = {
            return [self.VCInstance(name: "FirstVC"),self.VCInstance(name: "SecondVC"),self.VCInstance(name: "ThirdVC"),self.VCInstance(name: "FourthVC"),self.VCInstance(name: "FifthVC")]
    }()

    private func VCInstance(name:String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let FirstVC = VCArray.first{
            setViewControllers([FirstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    //MARK: - Change the background color of bottom indicating doted
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view1 in self.view.subviews{
        if view1 is UIScrollView {
            view1.frame = UIScreen.main.bounds
        }else if view1 is UIPageControl{
                view1.backgroundColor = UIColor.clear
            }
        }
    }
   
    //MARK: - Datasource of UIPageViewController
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        guard let viewcontrollerIndex = VCArray.index(of: viewController) else{
            return nil
        }
        let previousIndex = viewcontrollerIndex - 1
        
        guard previousIndex >= 0 else {
            return VCArray.last
        }
        guard VCArray.count > previousIndex else {
            return nil
        }
        return VCArray[previousIndex]
    }
  
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard let viewcontrollerIndex = VCArray.index(of: viewController) else{
            return nil
        }
        let nextIndex = viewcontrollerIndex + 1
        
        guard nextIndex < VCArray.count else {
            return VCArray.first
        }
        guard VCArray.count > nextIndex else {
            return nil
        }
        return VCArray[nextIndex]
    }

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        guard let firstviewcontroller = viewControllers?.first,
            let firstviewcontrollerIndex = VCArray.index(of: firstviewcontroller) else {
                return 0
        }
        return firstviewcontrollerIndex
    }
}
