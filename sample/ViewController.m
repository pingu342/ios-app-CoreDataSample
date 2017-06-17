//
//  ViewController.m
//  sample
//
//  Created by sakamotomasakiyo on 2017/06/04.
//  Copyright © 2017年 saka. All rights reserved.
//

#import "ViewController.h"
#import "MyDataController.h"
#import "Test.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.label.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// 永続ストアにTestオブジェクトを保存
//
- (IBAction)save:(id)sender {
    
    MyDataController *myData = [MyDataController sharedInstance];
    
    Test *test;
    NSError *error;
    
    // JSONデータを準備
    NSString *doc = [NSString stringWithFormat:@"{\"name\":\"%@\"}", self.textField.text];
    NSData *docData = [doc dataUsingEncoding:NSUTF8StringEncoding];
    
    // JSONデータをparseして、iOSのオブジェクト(NSDictionary)に変換
    id obj = [NSJSONSerialization JSONObjectWithData:docData options:0 error:&error];
    if (error) {
        NSLog(@"error");
    } else {
        // オブジェクト(NSDictionary)をTestオブジェクトに変換
        test = [Test objectWithProperties:obj inContext:myData.managedObjectContext];
        
        // Testオブジェクトを永続ストアに保存
        if ([[myData managedObjectContext] save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    }
}

//
// 永続ストアからTestオブジェクトをフェッチ
//
- (IBAction)fetch:(id)sender {
    
    MyDataController *myData = [MyDataController sharedInstance];
    
    NSError *error;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Test"];
    
    NSArray *results = [myData.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        self.label.text = @"Error";
    } else {
        if ([results count] > 0) {
            self.label.text = [(Test *)[results objectAtIndex:0] name];
        } else {
            self.label.text = @"No Data";
        }
    }
}

@end
