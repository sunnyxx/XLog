//
//  XLogger.m
//  XLog
//
//  Created by Sunny Sun on 12/12/13.
//  Copyright (c) 2013 Sunny Sun. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. The name of the author may not be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
//  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
//  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "XLoggerTableViewController.h"
#import "XLoggerTableViewCell.h"
#import "XLogData.h"

@interface XLoggerTableViewController ()
@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong) NSMutableArray *logs;
@property (nonatomic) BOOL hasLogTableViewShowed;
@property (nonatomic, strong) UIFont *logTextFont;
@end

NSString *const CellID = @"XLoggerTableViewCell";

@implementation XLoggerTableViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self)
    {
        self.rootViewController = rootViewController;
        self.logs = [NSMutableArray array];
    }
    return self;
}

- (void)receiveLogData:(XLogData *)data
{
    [self.logs addObject:data];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.rowHeight = 25.0f;
//    self.tableView = [[UITableView alloc] initWithFrame:self.rootViewController.view.bounds];
//    
//    [self.rootViewController.view addSubview:self.tableView];
    
    self.logTextFont = [UIFont systemFontOfSize:10.0f];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"XLoggerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellID];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, -CGRectGetHeight(self.view.frame));
    
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    topWindow.backgroundColor = [UIColor greenColor];
    topWindow.windowLevel = UIWindowLevelStatusBar + 1;
//    [topWindow makeKeyAndVisible];
    topWindow.hidden = NO;
    [self.view.window addSubview:topWindow];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [topWindow addGestureRecognizer:tap];
    
    UIView *view = [[UIView alloc] initWithFrame:topWindow.bounds];
    view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5f];
    [topWindow addSubview:view];
}

- (void)tap:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGFloat offset = self.hasLogTableViewShowed ? -CGRectGetHeight(self.view.frame) : CGRectGetHeight(self.view.frame);
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame = CGRectOffset(self.view.frame, 0, offset);
            self.hasLogTableViewShowed = !self.hasLogTableViewShowed;
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.logs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLoggerTableViewCell *cell = (XLoggerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    [cell setLogData:self.logs[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLogData *logData = self.logs[indexPath.row];
    CGSize titleSize = [logData.file sizeWithFont:self.logTextFont constrainedToSize:CGSizeMake(320.0f, INT_MAX)];
    CGSize textSize = [logData.output sizeWithFont:self.logTextFont constrainedToSize:CGSizeMake(320.0f, INT_MAX)];
    return titleSize.height + textSize.height + 5.0f /* reserved */;
}

@end
