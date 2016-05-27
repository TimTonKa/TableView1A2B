//
//  GuessViewController.m
//  HelloTableView
//
//  Created by XueXin Tsai on 2016/5/11.
//  Copyright © 2016年 XueXin Tsai. All rights reserved.
//

#import "GuessViewController.h"
#import "Round.h"
#import "MyTableViewController.h"

@interface GuessViewController ()
@property (weak, nonatomic) IBOutlet UITextField *playTextField;
@property (strong,nonatomic) NSArray * answer;
@property (strong,nonatomic) NSArray * userGuess;
@property (strong,nonatomic) NSMutableArray * guessHistory;
@end

@implementation GuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self randomNumber];
}

- (IBAction)getResult:(UIButton *)sender {
//    [self randomNumber];
    [self getUserGuess];
    
    NSMutableSet * answerSet = [NSMutableSet setWithArray:self.answer];
    NSMutableSet * userSet   = [NSMutableSet setWithArray:self.userGuess];
    
    // 將答案與使用者的猜測做交集
    [answerSet intersectSet:userSet];
    // 產生答案
    NSInteger incorrect = 4-answerSet.count;
    NSInteger correct = 0;
    for (NSNumber * number in answerSet) {
        //比對交集到的數字，是否符合答案與猜數字的位置相同
        NSInteger indexOfUserGuess = [self.userGuess indexOfObject:number];
        NSInteger indexOfAnswer    = [self.answer indexOfObject:number];
        if (indexOfUserGuess == indexOfAnswer) {
            correct += 1;
        }
    }
    // 準備 Round 的物件
    Round * round = [[Round alloc] init];
    round.userGuess = self.playTextField.text;
    round.result = [NSString stringWithFormat:@"%liA%liB",correct,4-incorrect-correct];
    
    // 將 round 物件存到陣列裡備查
    [self.guessHistory addObject:round];
    
    // 呈現提示視窗
    // 準備提示視窗
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"結果" message:round.result preferredStyle:UIAlertControllerStyleAlert];
    // 準備提示視窗的按鈕
    UIAlertAction * understand = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    // 將按鈕加到提示視窗上
    [alert addAction:understand];
    // 顯示提示視窗
    [self presentViewController:alert animated:true completion:nil];
    
    
    NSLog(@"這個結果是：%li A %li B",correct,4-incorrect-correct);
    
}

//產生隨機數字
-(void)randomNumber {
    self.guessHistory = [[NSMutableArray alloc] init];
    NSArray * array = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9];
    NSMutableSet * picked  = [[NSMutableSet alloc] init];
    
    while (picked.count != 4) {
        NSInteger index = arc4random() % 10;
        NSNumber * unit = array[index];
        [picked addObject:unit];
    }
    
    self.answer = [picked allObjects];
    NSLog(@"%@",self.answer);
}

// 取得文字框的字
-(void)getUserGuess {
    NSString * userTyped = self.playTextField.text;
    NSInteger guessNumber = userTyped.integerValue;
    //9875
    NSNumber * thousand = [NSNumber numberWithInteger:(guessNumber / 1000)];
    guessNumber %= 1000;
    
    NSNumber * hundred  = [NSNumber numberWithInteger:(guessNumber / 100)];
    guessNumber %= 100;
    
    NSNumber * ten      = [NSNumber numberWithInteger:(guessNumber / 10)];
    guessNumber %= 10;
    
    NSNumber * unit     = [NSNumber numberWithInteger:(guessNumber % 10)];
    
    self.userGuess = @[thousand,hundred,ten,unit];
    
//    NSLog(@"%@",guessArray);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MyTableViewController * nextTableVC = (MyTableViewController*)segue.destinationViewController;
    nextTableVC.history = self.guessHistory;
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

@end
