//
//  ChickenCountDownTests.swift
//  ChickenCountDownTests
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import XCTest
@testable import ChickenCountDown
@testable import KeychainSwift

class ChickenCountDownTests: XCTestCase {
    
    
    var storyBoard : UIStoryboard?
    var vc : ViewController?

    override func setUp() {
        super.setUp()
        storyBoard = UIStoryboard(name: "Main",bundle : nil)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidator(){
        let validator = Validator()
        
        let pw = "aaaaaaa"
        let id = "abbb"
        let pwAgain = "aaaaaaa"
        let pwlength = 6
        let idlength = 4
        let phonenum = "01049834332"
        
        
        let formatter = ISO8601DateFormatter()
        let dateString = "2017-07-25T00:00:00+09:00"
        let date =  formatter.date(from: dateString)
        let leftDays = 0
        
        XCTAssertFalse(validator.doesPwContainID(password : pw , id : id), "Password cotains ID")
        XCTAssertTrue(validator.checkLength(str : pw , length: pwlength), "Password should be longer than \(pwlength)")
        XCTAssertTrue(validator.checkLength(str : id , length: idlength), "Id should be longer than \(idlength)")
        XCTAssertTrue(validator.isEqual(string1 : pw , string2 : pwAgain), "Password does not match")
        XCTAssertTrue(validator.isValidPhoneNumber(num: phonenum), "This is not valid phone number")
        
        let phonenum2 = "ijrnbr"
        XCTAssertFalse(validator.isValidPhoneNumber(num: phonenum2), "This is valid phone number")
        XCTAssertFalse(validator.isFuture(date : date!), "Date is future from today")
        XCTAssertFalse(validator.checkLeftDays(date: date!) == leftDays, "Right left days")
        
    }
    
    func testRandom(){
        
        let random = RandomNumber()
        let num = 6
        
        XCTAssertTrue(random.makeRandom(num: num).characters.count == num,"숫자길이가 왜 이모양")
        XCTAssertFalse(random.makeRandom(num: 6) == random.makeRandom(num: 6),"this is not random number")
    }
    
    func testNetwork(){
        let network = Network()
        
        let phonenum = "01056691797"
        let random = RandomNumber()
        let randStr = random.makeRandom(num: 6)
        
        let expectation = XCTNSNotificationExpectation.init(name: "postSuccess")
        
        network.dataPost(phonenumber: phonenum, randNumber : randStr)
        
        wait(for: [expectation], timeout: 10.0)
    }

    
    func testKeyChain(){
        let user = User()
        user.id = "abbadf"
        user.password = "nkljlki"
        let keychain = KeychainSwift()
        let user2 = NSKeyedArchiver.archivedData(withRootObject: user)
        keychain.set(user2,forKey: "User")
        
        let data = keychain.getData("User")!
        let user3 = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
        
        XCTAssertTrue(user == user3, "keychain fails")
    }
    
    func testExample() {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
  
    func testCheckViewController() {
// 
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
