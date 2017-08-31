//
//  ViewController+ConfigureMainView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit


//TODO: Look into if i can explicitly apply this only when I'm in a navigationController, also consider adding a protocol or making all main views subclass from one to explicitly declare type.
extension  UIViewController {
    func configureView(_ stateView: UIView) {
        view.addSubview(stateView)
        stateView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
