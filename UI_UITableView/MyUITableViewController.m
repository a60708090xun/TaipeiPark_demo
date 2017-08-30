//
//  MyUITableViewController.m
//  TaipeiPark
//
//  Created by StackVC on 2017/8/26.
//  Copyright © 2017年 stackvc. All rights reserved.
//

#import "MyUITableViewController.h"
#import "DetailViewController.h"
#import "MyUITabelViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface MyUITableViewController ()

@end

@implementation MyUITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Taipei Park Attractions";
    

#if 0
    mData=[[NSMutableArray alloc] init];
    [mData addObject:@"yahoo.com"];
    [mData addObject:@"google"];
    [mData addObject:@"baidu.com"];
    [mData addObject:@"yam.com"];
    mResult=mData;
#endif
    
    // 台北公園景點資料 ID
    NSString *taipeiDataUrl = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
    
    NSURL *url = [NSURL URLWithString: taipeiDataUrl];
#if 0
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
#else
    NSURLSession *session = [NSURLSession sharedSession];
    NSData* __block data = nil;
    BOOL __block reqProcessed = false;
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *_data,
                                NSURLResponse *_response,
                                NSError *_error) {
                // handle response
                data = _data;
                reqProcessed = true;
            }] resume];
    
    while (!reqProcessed) {
        [NSThread sleepForTimeInterval:0];
    }
#endif
    
#if 0 // Json test
    //直接列印出Json格式的內容
    NSString* jSONString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json形式是: %@",jSONString);
#endif
    
    NSDictionary* jsonObj =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments
                                      error:nil];
    
    NSDictionary *result = [jsonObj objectForKey:@"result"];
    NSArray *resultsArr = [result objectForKey:@"results"];
    
    mDict = [self sortByParkName: resultsArr];
    
    
#if 1
    self.tableView.estimatedRowHeight = 68.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   
    //return [mResult count];
    return [mDict count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    MyUITabelViewCell *cell = (MyUITabelViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell==nil){

        cell=[[MyUITabelViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* t1=@"", *t2=@"", *t3=@"";
    NSString *imageStr = nil;
    //NSString* tstring=self.mUISearchBar1.text;
    //t1=[mResult objectAtIndex:indexPath.row];
    
    NSDictionary *site = [mDict objectAtIndex: indexPath.row];
    t1 = [site objectForKey:@"Name"];
    t2 = [site objectForKey:@"ParkName"];
    t3 = [site objectForKey:@"Introduction"];
    if ([t3 isEqualToString:@""]) {
        t3 = [NSString stringWithFormat:@"%@ in %@",
              [site objectForKey:@"Name"],
              [site objectForKey:@"ParkName"]];
    }
    
    imageStr = [site objectForKey:@"Image"];
    
    cell.mUILabel1.text=t1;
    cell.mUILabel2.text=t2;
    cell.mUITextView.text=t3;
    
    if (imageStr != nil) {
        [cell.mUIImageView1 sd_setImageWithURL:[NSURL URLWithString: imageStr]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else {
        cell.mUIImageView1.image = [UIImage imageNamed:@"default.png"];
    }
    
#if 0
    CGRect frame = cell.mUITextView.frame;
    CGSize size = [cell.mUITextView.text sizeWithFont:cell.mUITextView.font
                                constrainedToSize:CGSizeMake(280, 1000)
                                    lineBreakMode:UILineBreakModeWordWrap];
    frame.size.height = size.height > 1 ? size.height + 20 : 64;
    cell.mUITextView.frame = frame;
#endif
    
#if 0
    CGRect frame = cell.mUITextView.frame;
    frame.size.height = cell.mUITextView.contentSize.height;
    cell.mUITextView.frame = frame;
#endif
    
    cell.mUILabel1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.mUILabel2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.mUITextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowDetail"]){
        NSIndexPath* t2=[self.tableView indexPathForSelectedRow];
        NSDictionary *detail = [mDict objectAtIndex: t2.row];
        NSArray *related = [self findRelatedDict:detail];
        
        [[segue destinationViewController] setMRelatedArray: related];
        [[segue destinationViewController] setMDetailDict: detail];        
        
        //NSString* t1=[mResult objectAtIndex:t2.row];
        //[[segue destinationViewController] setMDetilString:t1];
    }
}

- (NSArray*)sortByParkName:(NSArray *) inputArr
{
    NSSortDescriptor *parkDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ParkName" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:parkDescriptor];
    NSArray *sortedArray = [inputArr sortedArrayUsingDescriptors:sortDescriptors];

    return (NSArray *)sortedArray;
}

- (NSArray*)findRelatedDict:(NSDictionary *) dict
{
    NSMutableArray *relatedDicts = [[NSMutableArray alloc] init];
    NSString *parkName = [dict objectForKey:@"ParkName"];
    NSString *_id = [dict valueForKey:@"_id"];
    
    int dictIndex = (int) [mDict indexOfObject: dict];
    
#if 1
    // data sorted by parkName
    // search backward
    int i=0;
    int miss = 0;
    for (i = dictIndex-1; i>=0; i--) {
        NSDictionary *tmp = [mDict objectAtIndex:i];
        NSString *tmpParkName = [tmp objectForKey:@"ParkName"];
        NSString *tmpid = [tmp objectForKey:@"_id"];
        if ([tmpParkName isEqualToString: parkName] && ![tmpid isEqualToString: _id]) {
            [relatedDicts addObject:tmp];
        }
        else if (miss++ > 5) {
            break;
        }
    }
    
    // search forward
    miss = 0;
    for (i = dictIndex+1; i<[mDict count]; i++) {
        NSDictionary *tmp = [mDict objectAtIndex:i];
        NSString *tmpParkName = [tmp objectForKey:@"ParkName"];
        NSString *tmpid = [tmp objectForKey:@"_id"];
        if ([tmpParkName isEqualToString: parkName] && ![tmpid isEqualToString: _id]) {
            [relatedDicts addObject:tmp];
        }
        else if (miss++ > 5){
            break;
        }
    }
#else
    // data does not in order?
    for (int i = 0; i<[mDict count]; i++) {
        NSDictionary *tmp = [mDict objectAtIndex:i];
        NSString *tmpParkName = [tmp objectForKey:@"ParkName"];
        NSString *tmpid = [tmp objectForKey:@"_id"];
        if ([tmpParkName isEqualToString: parkName] && ![tmpid isEqualToString: _id]) {
            [relatedDicts addObject:tmp];
        }
    }
    
#endif
    
    return (NSArray *)relatedDicts;
}

 
#if 0
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString* tstring=self.mUISearchBar1.text;
    if([tstring  length]>0){
        NSPredicate *re=[NSPredicate predicateWithFormat:@"SELF contains [search] %@", self.mUISearchBar1.text];
        mResult=[[mData filteredArrayUsingPredicate:re] mutableCopy];
    }else{
        mResult=mData;
    }
    [self.tableView reloadData];
}
#endif











@end
