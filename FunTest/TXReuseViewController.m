//
//  TXReuseViewController.m
//  FunTest
//
//  Created by Steven Cheung on 11/4/14.
//  Copyright (c) 2014 tx. All rights reserved.
//

#import "TXReuseViewController.h"
#import "TXTableCell1.h"
#import "TXTableCell2.h"

@interface TXReuseViewController ()

@end

@implementation TXReuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row%2) {
        TXTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"TXTableCell1"];
        if (cell == nil) {
            NSArray *cell1Nib = [[NSBundle mainBundle] loadNibNamed:@"TXTableCell1" owner:self options:nil];
            cell = [cell1Nib firstObject];
            UINib *nib = [UINib nibWithNibName:@"TXTableCell1" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:@"TXTableCell1"];
        }
        
        return cell;
    }
    else {
        TXTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"TXTableCell2"];
        if (cell == nil) {
            NSArray *cell1Nib = [[NSBundle mainBundle] loadNibNamed:@"TXTableCell2" owner:self options:nil];
            cell = [cell1Nib firstObject];
            UINib *nib = [UINib nibWithNibName:@"TXTableCell2" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:@"TXTableCell2"];
        }
        
        return cell;
    }
}

@end
