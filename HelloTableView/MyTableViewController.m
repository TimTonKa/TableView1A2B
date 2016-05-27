//
//  MyTableViewController.m
//  HelloTableView
//
//  Created by XueXin Tsai on 2016/5/9.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "MyTableViewController.h"
#import "Round.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Round * round1 = [[Round alloc] init];
//    round1.userGuess = @"5678";
//    round1.result    = @"1A2B";
//    
//    Round * round2 = [[Round alloc] init];
//    round2.userGuess = @"0651";
//    round2.result    = @"1A0B";
//    
//    Round * round3 = [[Round alloc] init];
//    round3.userGuess = @"6424";
//    round3.result    = @"2A1B";
//    
//    self.history = [NSMutableArray arrayWithArray:@[round1,round2,round3]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (IBAction)insertNewObject:(UIBarButtonItem *)sender {
    // 讓 Tableview 新增一列
    // 在哪裡新增一列 (NSIndexPath)
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // 該列的內容？
    Round * round = [[Round alloc] init];
    round.userGuess = @"8910";
    round.result    = @"0A0B";
    [self.history insertObject:round atIndex:0];
    
    // Tableview 畫面新增那一列
    [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.history.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Round * aRound = (Round*)self.history[indexPath.row];
    
    // 左邊的Label
    cell.textLabel.text = aRound.userGuess;
    
    // 右邊的Label
    cell.detailTextLabel.text = aRound.result;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            // 先動資料，把 history 陣列的第 n 個索引值的物件移除
            [self.history removeObjectAtIndex:indexPath.row];
            // 再動畫面
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case UITableViewCellEditingStyleInsert:
            break;
            
        case UITableViewCellEditingStyleNone:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
