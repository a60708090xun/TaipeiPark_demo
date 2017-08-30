//
//  DetailViewController.h
//  TaipeiPark
//
//  Created by StackVC on 2017/8/26.
//  Copyright © 2017年 stackvc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASHViewController.h"

@interface DetailViewController : UIViewController{
    
    //ASHViewController *slider;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *mUIImageView;
@property (strong, nonatomic) IBOutlet UILabel *mUILabel1;
@property (strong, nonatomic) IBOutlet UILabel *mUILabel2;
@property (strong, nonatomic) IBOutlet UILabel *mUILabel3;
@property (strong, nonatomic) IBOutlet UITextView *mUITextViewIntro;
@property (strong, nonatomic) IBOutlet UIView *mUIView;
@property (strong, nonatomic) IBOutlet UIScrollView *mUIScrollView;
@property (strong, nonatomic) IBOutlet UIView *mContentView;
@property (strong,nonatomic) NSString* mDetilString;
@property (strong,nonatomic) NSDictionary* mDetailDict;
@property (strong,nonatomic) NSArray* mDictArray;
@property (strong,nonatomic) NSArray* mRelatedArray;
@property (strong,nonatomic) ASHViewController *slider;

@end
