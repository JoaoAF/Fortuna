//
//  ViewController.swift
//  fortuna
//
//  Created by João Paulo de Araújo Ferreira on 26/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//

import UIKit

protocol FortunaToolbarProtocol: class {
    
    func didTapMaisBarButtonItem()
    func didTapMenosBarButtonItem()
    
}

class ViewController: UIPageViewController {

    var currentViewController: UIViewController?
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "Resumo"),
            self.getViewController(withIdentifier: "ResumoDetalhado")
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    @IBAction func maisBarButtonItem(_ sender: Any) {
        if let currentViewController = currentViewController as? FortunaToolbarProtocol {
            currentViewController.didTapMaisBarButtonItem()
        }
    }
    
    @IBAction func menosBarButtonItem(_ sender: Any) {
        if let currentViewController = currentViewController as? FortunaToolbarProtocol {
            currentViewController.didTapMenosBarButtonItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
                
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentViewController = pageViewController.viewControllers?.first
        }
    }
    
}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return nil } //pages.lasst
        
        guard pages.count > previousIndex else { return nil        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return nil } //pages.first
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
    
}

// https://medium.com/how-to-swift/how-to-create-a-uipageviewcontroller-a948047fb6af
