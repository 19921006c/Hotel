//
//  JNoteViewController.m
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//
#define kNoteData @"kNoteData"

#import "JNoteViewController.h"
#import "JRoomDetailedCell.h"
#import "JYYCacheTool.h"
#import "JRoomDetailedModel.h"
@interface JNoteViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allArray;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) JRoomDetailedModel *model;

@end

@implementation JNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allArray = [NSMutableArray arrayWithArray:[JYYCacheTool objectForKey:kNoteData]];
    
    if (!_allArray){//没有数据
        _allArray = [NSMutableArray array];
        
        JRoomDetailedModel *model = [[JRoomDetailedModel alloc]init];
        model.content = @"delete all home data";
        [_allArray addObject:model];
        
        JRoomDetailedModel *model2 = [[JRoomDetailedModel alloc]init];
        
        model2.content = @"delete all note data";
        [_allArray addObject:model2];
    }
    
    self.navigationItem.title = @"note";
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightDonw)];
    
}

- (void)rightDonw{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Add Note" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    _textField.placeholder = @"Please input";
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"title = %@",alertView.title);
    
    NSLog(@"message = %@",alertView.message);
    
    NSString *title = alertView.title;
    
    if ([title isEqualToString:@"Add Note"]) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            
            JRoomDetailedModel *model = [[JRoomDetailedModel alloc]init];
            
            model.content = _textField.text;
            
            [_allArray addObject:model];
            //存数据
            [self setObjectAndReload];
        }
    }
    
    if ([title isEqualToString:@"Edit Note"]) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            
            self.model.content = _textField.text;
            //存数据
            [self setObjectAndReload];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    
    return _allArray.count - 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRoomDetailedCell *cell = [JRoomDetailedCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        cell.index = 1;
    }else{
        cell.index = 0;
    }
    
    JRoomDetailedModel *model = [[JRoomDetailedModel alloc]init];
    
    if (indexPath.section == 0) {
        model = self.allArray[indexPath.row];
        cell.contnent = model.content;
    }else{
        model = self.allArray[indexPath.row + 2];
        cell.contnent = model.content;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_allArray removeObjectAtIndex:indexPath.row + 2];
        
        [self setObjectAndReload];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        if (row == 0) {
            [JYYCacheTool removeObjectForKey:kJHomeViewControllerData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshHomeData object:nil];
            return;
        }
        NSRange range = NSMakeRange(2, _allArray.count - 2);
        
        [_allArray removeObjectsInRange:range];
        
        [self setObjectAndReload];
        
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Edit Note" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enable", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    self.model = _allArray[indexPath.row + 2];
    
    _textField.text = self.model.content;
    
    [alertView show];
    
    
}

- (void)setObjectAndReload
{
    
    [JYYCacheTool setObject:_allArray forKey:kNoteData];
    
    [self.tableView reloadData];
}
@end
