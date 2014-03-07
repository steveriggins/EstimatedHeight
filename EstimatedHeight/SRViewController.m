//
//  SRViewController.m
//  EstimatedHeight
//
//  Created by Steven W. Riggins on 3/7/14.
//  Copyright (c) 2014 Steve Riggins. All rights reserved.
//

#import "SRViewController.h"

@interface SRTableViewDelegateWithEstimatedRowHeight : NSObject<UITableViewDataSource, UITableViewDelegate>
@end

@interface SRTableViewDelegateWithNOEstimatedRowHeightNONONO : NSObject<UITableViewDataSource, UITableViewDelegate>
@end

@interface SRViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL showWhatupSection;
@property (nonatomic, strong) SRTableViewDelegateWithEstimatedRowHeight *delegateWithEstimatedRowHeight;
@property (nonatomic, strong) SRTableViewDelegateWithNOEstimatedRowHeightNONONO *delegateWithoutEstimatedHeight;
@end


/**
 *  OVERVIEW OF CRASH
 *
 *  If you set a delegate on a UITableView that implements tableView:estimatedHeightForRowAtIndexPath:
 *  and later change the delegate to one that does not, and that new delegate also removes the section
 *  that was returning a custom height, UITableView crashes trying to access memory location 0
 *
 *  The crash happens after tapping reload in the nav bar
 */

@implementation SRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showWhatupSection = NO; // Will be toggled to yes at end of this method
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.delegateWithEstimatedRowHeight = [[SRTableViewDelegateWithEstimatedRowHeight alloc] init];
    self.delegateWithoutEstimatedHeight = [[SRTableViewDelegateWithNOEstimatedRowHeightNONONO alloc] init];
    
    [self reloadTable:nil];
}

- (IBAction)reloadTable:(id)sender;
{
    self.showWhatupSection = !self.showWhatupSection;
    
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    if (self.showWhatupSection)
    {
        // Use the delegate that implements tableView:estimatedHeightForRowAtIndexPath:
        self.tableView.dataSource = self.delegateWithEstimatedRowHeight;
        self.tableView.delegate = self.delegateWithEstimatedRowHeight;
    }
    else
    {
        // Switch to the delegate that does not implement tableView:estimatedHeightForRowAtIndexPath:
        self.tableView.dataSource = self.delegateWithoutEstimatedHeight;
        self.tableView.delegate = self.delegateWithoutEstimatedHeight;
    }
    [self.tableView reloadData]; // Crash here after tapping reload in the nav bar
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

/**
 *  This delegate has 3 sections of 1 row each
 *
 *  It implements tableView:estimatedHeightForRowAtIndexPath:
 */

@implementation SRTableViewDelegateWithEstimatedRowHeight
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *text;
    switch (indexPath.section)
    {
        case 0:
            text = @"hello";
            break;
        case 1:
            text = @"what's up";
            break;
        case 2:
        default:
            text = @"goodbye";
            break;
    }
    
    cell.textLabel.text = text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"estimate %@", indexPath);
    if (indexPath.section == 1)
    {
        return 128.0f;
    }
    return UITableViewAutomaticDimension;
    
}

@end

/**
 *  This delegate has 2 sections of 1 row each
 *
 *  It DOES NOT implement tableView:estimatedHeightForRowAtIndexPath:
 */

@implementation SRTableViewDelegateWithNOEstimatedRowHeightNONONO
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *text;
    switch (indexPath.section)
    {
        case 0:
            text = @"hello";
            break;
        case 1:
        default:
            text = @"goodbye";
            break;
    }
    
    cell.textLabel.text = text;
    return cell;
}
@end

