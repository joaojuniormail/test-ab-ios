//
//  MainView.swift
//  TestAB
//
//  Created by João Batista da Silva Junior - JBT on 17/06/21.
//

import UIKit
import VWO

class MainView: UIView {
    
    // MARK: Actions
    
    var enterButtonAction: (() -> Void)?
    var buyButtonAction: (() -> Void)?
    
    // MARK: Views
    
    var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let hexColorString = VWO.stringFor(key: "contentViewBorderColor", defaultValue: "#000000")!
        var borderColor:UIColor = Util.hexStringToUIColor(hex: hexColorString)
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var enterButton: UIButton = {
        let button = UIButton(type: .system)
        let titleButton = VWO.stringFor(key: "enterButtonName", defaultValue: "Entrar")
        button.setTitle(titleButton, for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let withBorderRadius = VWO.boolFor(key: "enterButtonWithBorderRadius", defaultValue: true)
        if withBorderRadius {
            button.layer.cornerRadius = 10
        }
        return button
    }()
    
    var buyButton: UIButton = {
        let button = UIButton(type: .system)
        let titleButton = "Comprar"
        button.setTitle(titleButton, for: .normal)
        let hexColorString = VWO.stringFor(key: "buyButtonColor", defaultValue: "#00FF00")!
        var backgroundColor:UIColor = Util.hexStringToUIColor(hex: hexColorString)
        button.tintColor = UIColor.white
        button.backgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let withBorderRadius = VWO.boolFor(key: "enterButtonWithBorderRadius", defaultValue: true)
        if withBorderRadius {
            button.layer.cornerRadius = 10
        }
        return button
    }()
    
    // MARK: Init
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupViews()
        self.setupConstraints()
        self.setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setupViews(){
        self.addSubview(self.contentView)
        self.addSubview(self.enterButton)
        self.addSubview(self.buyButton)
    }
    
    // MARK: View Constraints
    
    func setupConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupContentViewConstraints()
        self.setupEnterButtonConstraints()
        self.setupBuyButtonConstraints()
    }
    
    func setupContentViewConstraints(){
        self.contentView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupEnterButtonConstraints(){
        self.enterButton.topAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
        self.enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupBuyButtonConstraints(){
        self.buyButton.topAnchor.constraint(equalTo: self.enterButton.bottomAnchor, constant: 10).isActive = true
        self.buyButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    // MARK: Actions
    
    func setupActions(){
        self.enterButton.addTarget(self, action: #selector(self.onEnterButtonTouch), for: .touchUpInside)
        self.buyButton.addTarget(self, action: #selector(self.onBuyButtonTouch), for: .touchUpInside)
    }
    
    @objc func onEnterButtonTouch(){
        VWO.trackConversion("meta_login")
        self.enterButtonAction?()
    }
    
    @objc func onBuyButtonTouch(){
        self.buyButtonAction?()
    }
    
}
