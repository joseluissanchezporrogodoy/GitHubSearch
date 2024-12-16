//
//  GitHubSearchUITests.swift
//  GitHubSearchUITests
//
//  Created by JLSANCHEZP on 7/12/24.
//

import XCTest

final class GitHubSearchUITests: XCTestCase {
    func testErrorAlertIsPresented() throws {
            // Launch the application
            let app = XCUIApplication()
            app.launch()
            // Access the username TextField
            let usernameTextField = app.textFields["Enter GitHub username"]
            XCTAssertTrue(usernameTextField.exists, "The username text field should exist")
            // Enter an invalid username
            usernameTextField.tap()
            usernameTextField.typeText("nonexistent_user")
            // Tap the Search button
            let searchButton = app.buttons["Search"]
            XCTAssertTrue(searchButton.exists, "The search button should exist")
            searchButton.tap()
            // Verify that the Alert appears
            let alert = app.alerts["Error"]
            let exists = alert.waitForExistence(timeout: 10) // Wait for the alert to appear
            XCTAssertTrue(exists, "The error alert should be presented")
            // Verify the Alert Message
            let alertMessage = alert.staticTexts["User not found. Please enter another name."]
            XCTAssertTrue(alertMessage.exists, "The alert message should display the correct error text")
            // Dismiss the Alert
            alert.buttons["OK"].tap()
            XCTAssertFalse(alert.exists, "The alert should be dismissed after tapping OK")
        }
}
