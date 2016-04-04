//
//  RootViewController.m
//  KeepDemo
//
//  Created by Zachary on 3/25/16.
//  Copyright © 2016 Zachary. All rights reserved.
//

#import "RootViewController.h"
#import "APEGroupTableViewCell.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 0)
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[APEGroupCapTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([APEGroupCapTableViewCell class])];
    [tableView registerClass:[APEGroupMediumTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([APEGroupMediumTableViewCell class])];
    [tableView registerClass:[APEGroupBucketTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([APEGroupBucketTableViewCell class])];
    [tableView registerClass:[APEGroupRoundTalbeViewCell class]
           forCellReuseIdentifier:NSStringFromClass([APEGroupRoundTalbeViewCell class])];
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 3;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        APEGroupRoundTalbeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([APEGroupRoundTalbeViewCell class]) forIndexPath:indexPath];
      //  cell.insetX = 10;
        return cell;
    }
    else{
        if (indexPath.row == 0) {
            APEGroupCapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([APEGroupCapTableViewCell class]) forIndexPath:indexPath];
   //         cell.insetX = 10;

            return cell;
            
        }
        else if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
            APEGroupBucketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([APEGroupBucketTableViewCell class]) forIndexPath:indexPath];

      //      cell.insetX = 10;
            return cell;
            
        }
        else{
            APEGroupMediumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([APEGroupMediumTableViewCell class]) forIndexPath:indexPath];
            cell.indexPath = indexPath;
            cell.total = [self tableView:tableView numberOfRowsInSection:indexPath.section];

      //     cell.insetX = 10;
            return cell;
            
        }
    }
    return nil;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [cell setNeedsDisplay];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    header.contentView.backgroundColor = [UIColor whiteColor];

    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    footer.contentView.backgroundColor = [UIColor whiteColor];

    return footer;

}

@end
