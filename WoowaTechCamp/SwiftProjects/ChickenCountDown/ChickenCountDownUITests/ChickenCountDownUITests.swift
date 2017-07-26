//
//  ChickenCountDownUITests.swift
//  ChickenCountDownUITests
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest

class ChickenCountDownUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testJoinViewController(){
        
        let app = XCUIApplication()
        let textField = app.textFields["아이디"]
        textField.tap()
        textField.typeText("juneki")
        
        let secureTextField = app.secureTextFields["비밀번호"]
        secureTextField.typeText("m")
        secureTextField.tap()
        secureTextField.typeText("junekim")
        
        let secureTextField2 = app.secureTextFields["비밀번호 재확인"]
        secureTextField2.typeText("613")
        secureTextField2.tap()
        secureTextField2.typeText("junekim613")
        
    }
    
}
