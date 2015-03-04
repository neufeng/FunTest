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
    NSInteger row = indexPath.row;
    if (row%2) {
        TXTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"TXTableCell1"];
        if (cell == nil) {
            NSArray *cell1Nib = [[NSBundle mainBundle] loadNibNamed:@"TXTableCell1" owner:self options:nil];
            cell = [cell1Nib firstObject];
            UINib *nib = [UINib nibWithNibName:@"TXTableCell1" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:@"TXTableCell1"];
        }
        cell.titleLabel.text = @"Auto Layout";
        cell.contentLabel.text = @"随着iPhone6、iPhone6 Plus的到来，使用自适应布局更是迫在眉睫的事，固定布局的老传统思想脆弱的不堪一击。现在的iPhone有4种尺寸，如果算上iPad，现在Apple的iOS设备有5种尺寸。我们在准备使用自适应布局设计应用界面之前，可以把这5种尺寸划分为3种分辨率和屏幕方向，这样在设计时分类会更加清晰一些。";
        cell.nameLabel.text = @"Apple";
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        CGFloat height = size.height;
        
        return height+1;
    }
    
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
        
        cell.titleLabel.text = @"Auto Layout";
        cell.contentLabel.text = @"随着iPhone6、iPhone6 Plus的到来，使用自适应布局更是迫在眉睫的事，固定布局的老传统思想脆弱的不堪一击。现在的iPhone有4种尺寸，如果算上iPad，现在Apple的iOS设备有5种尺寸。我们在准备使用自适应布局设计应用界面之前，可以把这5种尺寸划分为3种分辨率和屏幕方向，这样在设计时分类会更加清晰一些。";
        cell.nameLabel.text = @"Apple";
        
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
