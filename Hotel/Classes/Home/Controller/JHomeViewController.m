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

//固定的服务个数
@property (nonatomic, assign)NSInteger setCount;
//储存刚拿到数据的id,用来判断订阅是否有变化
@property (nonatomic, copy)NSString *strId;

@end

@implementation JHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self setNavigationBar];
    
    NSArray *roomNo = [NSArray arrayWithObjects:@"101", @"102", @"103", @"104", @"105", @"106", @"107", @"108", @"109", @"110", @"111", @"112", @"201", @"202", @"203", @"204", @"205", @"206", @"207", @"208", @"209", @"210", @"211", @"212", @"213",nil];
//    NSArray *praise = [NSArray arrayWithObjects:@"", nil];
    
    _otherArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    
    for (int i = 0; i < roomNo.count; i ++) {
        JRoomModel *model = [[JRoomModel alloc]init];
        
        model.roomNo = [roomNo[i] integerValue];
        model.roomId = [roomNo[i] integerValue];
//        model.roomPrasie = [praise[i] integerValue];
        [_otherArray addObject:model];
    }
    [self setCollectionViewAttributes];
}

- (void)setNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
}

- (void)addAction{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"输入内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    _textField = [alertView textFieldAtIndex:0];
    
    _textField.placeholder = @"请输入内容";
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) {

        JRoomModel *model = [[JRoomModel alloc]init];
        
        model.roomNo = [_textField.text integerValue];
        
        model.roomId = [_textField.text integerValue];
        
        [_otherArray addObject:model];
        
        [self.collectionView reloadData];
    }
}

- (void)setCollectionViewAttributes{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyReaderCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyReaderCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyReaderCollectionAddCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyReaderCollectionAddCell"];
    //    self.selectCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_bg"]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //
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
        
        cell.label.text = [NSString stringWithFormat:@"%ld",model.roomNo];
    }else{
        
        
        model = _otherArray[indexPath.row];
        
        cell.label.text = [NSString stringWithFormat:@"%ld",model.roomNo];
    }
//    //创建模型
//    if (indexPath.section == 0) {
////        model = self.selectedArray[indexPath.row];
////        cell.label.text = model.name;
////        cell.label.textColor = [UIColor colorWithHexString:@"#333333"];
////        //固定的服务，样式
////        //        FLOG(@"name = %@ type = %d", model.name,model.type);
////        if (model.type == 2) {
////            cell.label.textColor = [UIColor colorWithHexString:@"#999999"];
////        }
//        
//    }else{
//        MyReaderCollectionAddCell *cell = (MyReaderCollectionAddCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyReaderCollectionAddCell" forIndexPath:indexPath];
//        model = self.otherArray[indexPath.row];
//        cell.label.text = model.name;
//        
//        return cell;
//    }
    return cell;
};



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        MyReaderHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyReaderHeaderCollectionReusableView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.label.text = @"已租";
        }else{
            header.label.text = @"未出租";
        }

        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
    MyReaderFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyReaderFooterCollectionReusableView" forIndexPath:indexPath];
    footer.backgroundColor = [UIColor whiteColor];
    return footer;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < self.setCount; i ++) {
        if (indexPath.row == i && indexPath.section == 0) {
            return;
        }
    }
    if (indexPath.section == 0) {
        [self.otherArray insertObject:[self.selectedArray objectAtIndex:indexPath.row] atIndex:0];
        [self.selectedArray removeObjectAtIndex:indexPath.row];
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [collectionView reloadItemsAtIndexPaths:@[toIndexPath]];
    }else{
        [self.selectedArray addObject:[self.otherArray objectAtIndex:indexPath.row]];
        [self.otherArray removeObjectAtIndex:indexPath.row];
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:1];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArray.count - 1 inSection:0];
        [collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [collectionView reloadItemsAtIndexPaths:@[toIndexPath]];
    }
    
    if (self.otherArray.count >= 50 || self.selectedArray.count >= 30) {
        [collectionView reloadData];
    }
}

//长按手势
- (IBAction)longPressGestureRecognized:(id)sender {
    
}


@end
