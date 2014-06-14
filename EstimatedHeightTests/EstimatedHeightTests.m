//
//  EstimatedHeightTests.m
//  EstimatedHeightTests
//
//  Created by Steven W. Riggins on 3/7/14.
//  Copyright (c) 2014 Steve Riggins. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRSimpleModel.h"

@interface EstimatedHeightTests : XCTestCase

@end

@implementation EstimatedHeightTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSimpleModel
{
    SRSimpleModel *simpleModel = [[SRSimpleModel alloc] init];
    NSUInteger testValue = simpleModel.testValue;
    XCTAssertTrue(testValue == 100, @"testValue was %d, should be %d", testValue, 100);
}

@end
