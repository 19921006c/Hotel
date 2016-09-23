//
//  JRoomDetailedViewController.m
//  Hotel
//
//  Created by J on 16/7/16.
//  Copyright © 2016年 J. All rights reserved.
//
#define kRoomDetailedKey [NSString stringWithFormat:@"%@%ld",_roomModel.roomName,_roomModel.roomId]

#import "JRoomDetailedViewController.h"
#import "JRoomModel.h"
#import "JYYCacheTool.h"
#import "JRoomDetailedCell.h"
#import "JRoomDetailedModel.h"
@interface JRoomDetailedViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allArray;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) JRoomDetailedModel *detailedModel;

@end

@implementation JRoomDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据处理
    [self dataProcess];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(rightDown)];
}

- (void)dataProcess
{
    _allArray = [JYYCacheTool objectForKey:kRoomDetailedKey];
    
    if (_allArray.count > 0) {//有数据
        
    }else{//没数据
        _allArray = [NSMutableArray array];
        
        JRoomDetailedModel *detailedModel = [[JRoomDetailedModel alloc]init];
        
        detailedModel.content = @"点击添加一条内容";
        
        [_allArray addObject:detailedModel];
        
        [self reloadAndSetObject];
    }
}

- (void)rightDown
{
    NSMutableArray *allArray = [JYYCacheTool objectForKey:kJHomeViewControllerData];
    
    for (int i = 0; i < allArray.count; i ++) {
        JRoomModel *model = allArray[i];
        
        if ([model.roomId isEqualToString:_roomModel.roomId]) {
            [allArray removeObject:model];
        }
    }
    
    [JYYCacheTool setObject:allArray forKey:kJHomeViewControllerData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshHomeData object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRoomDetailedCell *cell = [JRoomDetailedCell cellWithTableView:tableView];
    
    JRoomDetailedModel *detailedModel = _allArray[indexPath.row];
    
    cell.contnent = detailedModel.content;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRoomDetailedModel *detailedModel = _allArray[indexPath.row];
    
    return detailedModel.contentHeiht;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    _detailedModel = _allArray[indexPath.row];
    
    _textField.text = _detailedModel.content;
    
    [alertView show];
    
    if ((indexPath.row + 1) == _allArray.count) {//点击最后一个cell
        JRoomDetailedModel *detailedModel = [[JRoomDetailedModel alloc]init];
        detailedModel.content = @"点击添加一条详情";
        [_allArray addObject:detailedModel];
        
        [self reloadAndSetObject];
        alertView.tag = 10000;
    }else{
        alertView.tag = 10001;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"tag = %ld",alertView.tag);
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        
        _detailedModel.content = _textField.text;
        
        [self reloadAndSetObject];
        return;
    }
    
    if (alertView.tag == 10000) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            [_allArray removeLastObject];
            [self reloadAndSetObject];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_allArray removeObjectAtIndex:indexPath.row];
        
        [self reloadAndSetObject];
    }
}

//写数据和刷新tableview 抽方法
- (void)reloadAndSetObject
{
    [self setObjetc];
    [self.tableView reloadData];
}

//写数据
- (void)setObjetc{
    [JYYCacheTool setObject:_allArray forKey:kRoomDetailedKey];
}

- (void)setRoomModel:(JRoomModel *)roomModel
{
    _roomModel = roomModel;
    
    self.title = roomModel.roomName;
}

@end
