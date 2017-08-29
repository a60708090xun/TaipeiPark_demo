//
//  ASHViewController.h
//  TaipeiPark
//
//  Created by StackVC on 2017/8/28.
//  Copyright © 2017年 stackvc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHorizontalScrollView.h"

@interface ASHViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *sampleTableView;
}

@property (strong,nonatomic) NSArray* mRelatedDicts;

@end
