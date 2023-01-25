//
//  TestsUsersService.swift
//  SampleForInterviewTests
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import XCTest
@testable import SampleForInterview

final class TestsUsersService: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_fetchUsers_success() throws {
        let apiClient = MockApiClient(expectedSuccessResult: PageResponse(data: [User.sample, User.sample]))
        let usersApiService: UserApiServiceProtocol = UserApiService(with: apiClient)
        let usersService: UsersServiceProtocol = UsersService(client: usersApiService)
        
        let exp = XCTestExpectation(description: "fetch users")
        usersService.loadUsers(page: 0) { result in
            switch result {
            case .success(let success):
                XCTAssert(success.data.count == 2, "should be 2 but get \(success.data.count)")
                XCTAssert(success.data.count != 3, "should be 2 but get \(success.data.count)")
            case .failure(let failure):
                XCTAssertTrue(false, "should be succsess \(failure)")
            }
            
            exp.fulfill()
        }
        
        self.wait(for: [exp], timeout: 1)
    }
    
    func test_fetchUsers_failed() throws {
        let apiClient = MockApiClient(expectedError: .noData)
        let usersApiService: UserApiServiceProtocol = UserApiService(with: apiClient)
        let usersService: UsersServiceProtocol = UsersService(client: usersApiService)
        
        let exp = XCTestExpectation(description: "fetch users")
        usersService.loadUsers(page: 0) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(false, "should be failed \(success)")
            case .failure(let failure):
                XCTAssertTrue(true, "should be failed \(failure)")
            }
            
            exp.fulfill()
        }
        
        self.wait(for: [exp], timeout: 1)
    }
}
