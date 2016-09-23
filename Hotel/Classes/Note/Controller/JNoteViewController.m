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
#import "JRoomDetailedViewController.h"
#import "JRoomModel.h"
@interface JNoteViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *allArray;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) JRoomDetailedModel *model;

@property (nonatomic, strong) NSMutableArray *searchArr;

@end

@implementation JNoteViewController

- (NSMutableArray *)searchArr
{
    if (!_searchArr) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allArray = [NSMutableArray arrayWithArray:[JYYCacheTool objectForKey:kNoteData]];
    
    if (_allArray.count == 0){//没有数据
        _allArray = [NSMutableArray array];
        
        JRoomDetailedModel *model = [[JRoomDetailedModel alloc]init];
        model.content = @"删除'首页'所有数据";
        model.id = [NSString stringWithFormat:@"2000%@",model.content];
        [_allArray addObject:model];
        
        JRoomDetailedModel *model2 = [[JRoomDetailedModel alloc]init];
        
        model2.content = @"删除'记事'所有数据";
        model2.id = [NSString stringWithFormat:@"2000%@",model2.content];
        [_allArray addObject:model2];
    }
    
    self.navigationItem.title = @"记事";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightDonw)];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    //    self.searchView.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView addGestureRecognizer:longPress];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    
    searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    searchDisplayController.searchResultsDelegate = self;
    
}

//长按手势
- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if (indexPath.row < 2) return;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"编辑" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    self.model = _allArray[indexPath.row];
    
    _textField.text = self.model.content;
    
    [alertView show];
}

- (void)rightDonw{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"添加一条记事" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    _textField.placeholder = @"请输入内容";
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = alertView.title;
    
    if ([title isEqualToString:@"添加一条记事"]) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            
            JRoomDetailedModel *model = [[JRoomDetailedModel alloc]init];
            
            model.content = _textField.text;
            
            model.id = [NSString stringWithFormat:@"2000%@",model.content];
            [_allArray addObject:model];
            //存数据
            [self setObjectAndReload];
        }
    }
    
    if ([title isEqualToString:@"编辑"]) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            
            self.model.content = _textField.text;
            //存数据
            [self setObjectAndReload];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return _allArray.count;
    }else{
        return self.searchArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRoomDetailedCell *cell = [JRoomDetailedCell cellWithTableView:tableView];
    
    if (tableView == self.tableView) {
        
        JRoomDetailedModel *model = [[JRoomDetailedModel alloc]init];
        
        model = self.allArray[indexPath.row];
        cell.contnent = model.content;
        
    }else{
        JRoomDetailedModel *model = self.searchArr[indexPath.row];
        
        cell.contnent = model.content;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    JRoomDetailedModel *detailedModel = _allArray[indexPath.row];
    
    return detailedModel.contentHeiht;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 2) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_allArray removeObjectAtIndex:indexPath.row];
        
        [self setObjectAndReload];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row < 2) {
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
    
    JRoomDetailedModel *detailedModel = self.allArray[indexPath.row];
    
    JRoomModel *roomModel = [[JRoomModel alloc] init];
    
    roomModel.roomName = detailedModel.content;
    roomModel.roomId = detailedModel.id;
    JRoomDetailedViewController *vc = [[JRoomDetailedViewController alloc] init];
    
    vc.roomModel = roomModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)setObjectAndReload
{
    
    [JYYCacheTool setObject:_allArray forKey:kNoteData];
    
    [self.tableView reloadData];
}

#pragma mark - UISearch bar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self -> searchBar setShowsCancelButton:YES animated:YES];
    [searchDisplayController setActive:YES animated:YES];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchArr removeAllObjects];
    
    for (JRoomDetailedModel *model in self.allArray) {
        
            if ([model.content rangeOfString:searchText].location != NSNotFound) {
                
                [self.searchArr addObject:model];
            }
        
    }
    [self.searchDisplayController.searchResultsTableView reloadData];
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self -> searchBar.text = @"";
    //    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [self -> searchBar resignFirstResponder];
    [self -> searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dealloc{
    searchBar.delegate = nil;
}
@end
