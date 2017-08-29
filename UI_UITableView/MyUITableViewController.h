//
//  MyUITableViewController.h
//  TaipeiPark
//
//  Created by StackVC on 2017/8/26.
//  Copyright © 2017年 stackvc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyUITableViewController : UITableViewController<UISearchBarDelegate>{
    
    NSMutableArray* mData;
    NSMutableArray* mResult;
    
    NSArray* mDict;
    
}
@property (strong, nonatomic) IBOutlet UISearchBar *mUISearchBar1;

@end
