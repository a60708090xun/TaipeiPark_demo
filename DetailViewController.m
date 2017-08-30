//
//  DetailViewController.m
//  TaipeiPark
//
//  Created by StackVC on 2017/8/26.
//  Copyright © 2017年 stackvc. All rights reserved.
//

#import "DetailViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize mUILabel1, mUILabel2, mUILabel3;
@synthesize mUITextViewIntro;
@synthesize mUIImageView;
@synthesize mUIView;
@synthesize mUIScrollView;
@synthesize mRelatedArray;
@synthesize slider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //mUILabel1.text=self.mDetilString;
    
    NSString *imageStr = nil;
    imageStr = [self.mDetailDict objectForKey:@"Image"];
    
    if (imageStr != nil) {
        [mUIImageView sd_setImageWithURL:[NSURL URLWithString: imageStr]
                        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else {
        mUIImageView.image = [UIImage imageNamed:@"default.png"];
    }
    
    mUILabel1.text= [self.mDetailDict objectForKey:@"ParkName"];
    mUILabel2.text= [self.mDetailDict objectForKey:@"Name"];
    mUILabel3.text= [NSString stringWithFormat: @"開放時間： %@", [self.mDetailDict objectForKey:@"OpenTime"]];
    mUITextViewIntro.text= [self.mDetailDict objectForKey:@"Introduction"];
    if ([mUITextViewIntro.text isEqualToString:@""]) {
        mUITextViewIntro.text = [NSString stringWithFormat:@"%@ in %@, it's a magical place.",
                                 [self.mDetailDict objectForKey:@"Name"],
                                 [self.mDetailDict objectForKey:@"ParkName"]];
    }
    
    self.mUITextViewIntro.translatesAutoresizingMaskIntoConstraints = true;
    [self.mUITextViewIntro sizeToFit];
    mUITextViewIntro.scrollEnabled = false;
    
    //NSLog(@"%@ Intro text h=%.1f", mUILabel2.text, mUITextViewIntro.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    
    if (mRelatedArray != nil) {
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setMRelatedDicts: mRelatedArray];
}

@end
