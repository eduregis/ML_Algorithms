//
//  ViewController.swift
//  ML_Algorithms
//
//  Created by Eduardo Oliveira on 17/06/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    let characterListView = UIHostingController(rootView: SwiftUIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
//        self.view.addSubview(headerButton)
        addChild(characterListView)
        view.addSubview(characterListView.view)
        characterListView.didMove(toParent: self)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("apareceu!")
    }
    

    fileprivate func setupConstraints() {
        
        characterListView.view.translatesAutoresizingMaskIntoConstraints = false
        characterListView.view.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        characterListView.view.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        characterListView.view.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        characterListView.view.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    }



}

