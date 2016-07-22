//
//  JHomeViewController.m
//  Hotel
//
//  Created by J on 16/7/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JHomeViewController.h"
#import "MyReaderCollectionCell.h"
#import "MyReaderHeaderCollectionReusableView.h"
#import "MyReaderFooterCollectionReusableView.h"
#import "JRoomModel.h"
#import "JRoomDetailedViewController.h"
#import "JYYCacheTool.h"
@interface JHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UITextField *textField;
/**
 *  固定的服务放前面，已经添加的服务放后面
 */
@property (strong , nonatomic) NSMutableArray *selectedArray;

/**
 *  没有定制的服务
 */
@property (strong , nonatomic) NSMutableArray *otherArray;

@property (nonatomic, strong) NSMutableArray *allArray;

//固定的服务个数
@property (nonatomic, assign)NSInteger setCount;
//储存刚拿到数据的id,用来判断订阅是否有变化
@property (nonatomic, copy)NSString *strId;

@end

@implementation JHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"home";
    
    [self setNavigationBar];
    
    //数据处理
    [self dataProcess];
    
    [self setCollectionViewAttributes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataProcess) name:kRefreshHomeData object:nil];
}

- (void)dataProcess
{
    _allArray = [NSMutableArray arrayWithArray:[JYYCacheTool objectForKey:kJHomeViewControllerData]];
    
    _otherArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    
    if (_allArray.count > 0) {//有数据
        
        for (JRoomModel *model in _allArray) {//遍历
            
            if (model.selectedType == SelectedTypeYes) {
                [_selectedArray addObject:model];
            }else{
                [_otherArray addObject:model];
            }
        }
        
    }
    
    [self.collectionView reloadData];
}

- (void)setNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
}

- (void)addAction{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"input" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    _textField.placeholder = @"Please input";
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) {

        if ([_textField.text isEqualToString:@"鑫昊月"]) {
            NSArray *roomNo = [NSArray arrayWithObjects:@"101", @"102", @"103", @"104", @"105", @"106", @"107", @"108", @"109", @"110", @"111", @"112", @"201", @"202", @"203", @"204", @"205", @"206", @"207", @"208", @"209", @"210", @"211", @"212", @"213",nil];
            
            for (int i = 0; i < roomNo.count; i ++) {
                JRoomModel *model = [[JRoomModel alloc]init];
                
                model.roomName = [NSString stringWithFormat:@"%@",roomNo[i]];
                model.roomId = [NSString stringWithFormat:@"1000%@",model.roomName];
                model.selectedType = SelectedTypeNone;
                
                [_allArray addObject:model];
                
                [self setDataProcess];
            }
            
            [_otherArray addObjectsFromArray:_allArray];
            
            [self.collectionView reloadData];
            return;
        }
        
        JRoomModel *model = [[JRoomModel alloc]init];
        
        model.roomName = _textField.text;
        
        model.roomId = [NSString stringWithFormat:@"1000%@",model.roomName];
        
        model.selectedType = SelectedTypeNone;
        
        [_allArray addObject:model];
        
        //存数据
        [self setDataProcess];
        
        [_otherArray addObject:model];
        
        [self.collectionView reloadData];
    }
}
- (void)setDataProcess
{
    [JYYCacheTool setObject:_allArray forKey:kJHomeViewControllerData];
}

// load collection view attributes
- (void)setCollectionViewAttributes{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyReaderCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyReaderCollectionCell"];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyReaderHeaderCollectionReusableView" bundle:[NSBundle mainBundle]]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyReaderHeaderCollectionReusableView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyReaderFooterCollectionReusableView" bundle:[NSBundle mainBundle]]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyReaderFooterCollectionReusableView"];
    
    UICollectionViewFlowLayout *categoryFlowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    int width  = ([[UIScreen mainScreen] bounds].size.width - 40)/3 ;
    int height = 33 ;
    categoryFlowLayout.itemSize = CGSizeMake(width, height);
    categoryFlowLayout.minimumInteritemSpacing = 0 ;
    categoryFlowLayout.minimumLineSpacing = 10;
    categoryFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置section的边距
    categoryFlowLayout.headerReferenceSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 54);
    categoryFlowLayout.footerReferenceSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 18);
    
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark - Collection View Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.selectedArray.count;
    }
    return self.otherArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyReaderCollectionCell *cell =(MyReaderCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyReaderCollectionCell" forIndexPath:indexPath ];
    JRoomModel *model = [[JRoomModel alloc]init];
    
    if (indexPath.section == 0) {
        
        model = _selectedArray[indexPath.row];
        
        cell.label.text = model.roomName;
    }else{
        
        
        model = _otherArray[indexPath.row];
        
        cell.label.text = model.roomName;
    }
    return cell;
};



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        MyReaderHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyReaderHeaderCollectionReusableView" forIndexPath:indexPath];
        
        header.index = indexPath.section;

        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
    MyReaderFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyReaderFooterCollectionReusableView" forIndexPath:indexPath];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath.row == %ld",indexPath.row);
    if (indexPath.section == 0) {
        JRoomModel *roomModel = _selectedArray[indexPath.row];
        
        roomModel.selectedType = SelectedTypeNone;
        
        [self.otherArray insertObject:[self.selectedArray objectAtIndex:indexPath.row] atIndex:0];
        
        
        [self.selectedArray removeObjectAtIndex:indexPath.row];
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [collectionView reloadItemsAtIndexPaths:@[toIndexPath]];
    }else{
        JRoomModel *roomModel = _otherArray[indexPath.row];
        
        roomModel.selectedType = SelectedTypeYes;
        
        [self.selectedArray addObject:[self.otherArray objectAtIndex:indexPath.row]];
        [self.otherArray removeObjectAtIndex:indexPath.row];
        
        
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:1];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArray.count - 1 inSection:0];
        [collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [collectionView reloadItemsAtIndexPaths:@[toIndexPath]];
    }
    
    [self setDataProcess];
}

//长按手势
- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    JRoomModel *roomModel = [[JRoomModel alloc] init];
    
    if (indexPath.section == 0) {
        roomModel = _selectedArray[indexPath.row];
    }else{
        roomModel = _otherArray[indexPath.row];
    }
    
    if (state == UIGestureRecognizerStateBegan) {
        
        JRoomDetailedViewController *vc = [[JRoomDetailedViewController alloc] init];
        
        vc.roomModel = roomModel;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
    
}


@end
