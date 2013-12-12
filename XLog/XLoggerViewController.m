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

#import "XLoggerViewController.h"

@interface XLoggerViewController ()
@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong) NSMutableArray *logs;
@property (nonatomic, strong) UILabel *previewLabel;
@end

@implementation XLoggerViewController

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

- (void)receiveLog:(NSString *)msg
{
    self.previewLabel.text = msg;
    [self.logs addObject:msg];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 25.0f;
//    self.tableView = [[UITableView alloc] initWithFrame:self.rootViewController.view.bounds];
//    
//    [self.rootViewController.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, -CGRectGetHeight(self.view.frame));
    
    UIView *previewView = [[UIView alloc] initWithFrame:CGRectMake(0, 20.0f, CGRectGetWidth(self.rootViewController.view.bounds), 30.0f)];
    previewView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5f];
    [self.rootViewController.view addSubview:previewView];
    [self.rootViewController.view bringSubviewToFront:previewView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [previewView addGestureRecognizer:tap];
    
    self.previewLabel = [[UILabel alloc] initWithFrame:previewView.bounds];
    self.previewLabel.text = [self.logs firstObject] ?: @"";
    [previewView addSubview:self.previewLabel];
    
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    topWindow.backgroundColor = [UIColor greenColor];
    topWindow.windowLevel = UIWindowLevelStatusBar;
//    [topWindow makeKeyAndVisible];
    topWindow.hidden = NO;
    [self.view.window addSubview:topWindow];
    
    UIView *view = [[UIView alloc] initWithFrame:topWindow.bounds];
    view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5f];
    [topWindow addSubview:view];
}

- (void)tap:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame = CGRectOffset(self.view.frame, 0, CGRectGetHeight(self.view.frame));
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
    static NSString *const cellID = @"logCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        // TODO: 可以给cell一个结构化log对象进行显示
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.minimumScaleFactor = 0.5f;
        NSString *log = self.logs[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:8.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:8.0f];

        cell.textLabel.text = @"11111111111111111111";
        cell.detailTextLabel.text = log;
    }
    return cell;
}

@end
