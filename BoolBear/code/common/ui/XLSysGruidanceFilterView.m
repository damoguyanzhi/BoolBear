//
//  XLSysGruidanceFilterView.m
//  XueLeTS
//
//  Created by RuqiangLiu on 2020/6/17.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import "XLSysGruidanceFilterView.h"
#import "UIView+XL.h"
#import <Masonry/Masonry.h>

#define ItemHeight 36

#define ItemMaxNum 6

#define TableViewRightOrBottomDistance 10

@implementation XLSysGruidanceFilterModel

@end

@implementation XLSysGruidanceFilterItemModel


@end

@interface XLSysGruidanceFilterView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy) XLSysGruidanceFilterBlock chooseBlock;

@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic,assign)NSInteger selectSectionIndex;

@end

@implementation XLSysGruidanceFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addShadowSize:CGSizeMake(0, 2) Opacity:0.2];
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.tableView.frame, point)) {
        [self removeFromSuperview];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XLSysGruidanceFilterModel *sectionModel = self.dataArray[section];
    return sectionModel.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建重用标识符
    static NSString *identifier = @"gradeTableCell";
    
    // 2.去重用队列中根据标识符取可重用的cell
    UITableViewCell *gradeCell=  [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // 3.判断是否获取到可重用的cell(最后要空间释放)
    if (!gradeCell) {
        gradeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        gradeCell.textLabel.textColor=@"#212121".toColor;
        gradeCell.textLabel.font=[UIFont systemFontOfSize:12];
    }
    
    
    if ( indexPath.section == self.selectSectionIndex && indexPath.row == self.selectIndex) {
        gradeCell.backgroundColor = @"#f5f5f5".toColor;
    }else{
        gradeCell.backgroundColor = @"#ffffff".toColor;
    }
    
    XLSysGruidanceFilterModel *sectionModel = self.dataArray[indexPath.section];
    XLSysGruidanceFilterItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    gradeCell.textLabel.text= itemModel.name;
    
    return gradeCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, ItemHeight)];
    view.backgroundColor = [UIColor whiteColor];
    XLSysGruidanceFilterModel *sectionModel = self.dataArray[section];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 100, 10)];
    label.textColor = @"#757575".toColor;
    label.font = [UIFont systemFontOfSize:10];
    label.text = sectionModel.sectionName;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.centerY.offset(0);
        make.height.offset(10);
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.chooseBlock){
        self.chooseBlock(indexPath.section,indexPath.row);
    }
    
    [self removeFromSuperview];
}


#pragma mark - public method

+ (instancetype)showInView:(NSMutableArray *)array
  currentView:(UIView *)currentView
    viewWidth:(CGFloat)viewWidth
        block:(XLSysGruidanceFilterBlock)resultBlock{
    return [self showInView:array selectSectionIndex:-1  selectIndex:-1 currentView:currentView viewWidth:viewWidth block:resultBlock];
}


+ (instancetype)showInView:(NSMutableArray *)array
        selectSectionIndex:(NSInteger)selectSectionIndex
               selectIndex:(NSInteger)index
               currentView:(UIView *)currentView
                 viewWidth:(CGFloat)viewWidth
                     block:(XLSysGruidanceFilterBlock)resultBlock{
    
    UIView *win = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [currentView.superview convertRect:currentView.frame toView:win];
    CGFloat viewX = rect.origin.x + viewWidth + TableViewRightOrBottomDistance > win.width ? win.width - TableViewRightOrBottomDistance - viewWidth : rect.origin.x;
    NSInteger length = array.count > ItemMaxNum?ItemMaxNum:array.count;
    if(array.count < ItemMaxNum){
        NSInteger totalItem = array.count;
        for(XLSysGruidanceFilterModel *sectionModel in array){
            totalItem = totalItem + sectionModel.itemArray.count;
        }
        if(totalItem > ItemMaxNum){
            length = ItemMaxNum;
        }else{
            length = totalItem;
        }
    }

    CGFloat viewBoxHeight = ItemHeight*length;
    
    CGFloat viewY = rect.origin.y + currentView.height + TableViewRightOrBottomDistance + viewBoxHeight > win.height ? (win.height - viewBoxHeight-TableViewRightOrBottomDistance):(rect.origin.y + currentView.height + TableViewRightOrBottomDistance);
    
    XLSysGruidanceFilterView *tipView = [[XLSysGruidanceFilterView alloc]initWithFrame:win.bounds];
    tipView.chooseBlock = resultBlock;
    tipView.dataArray = array;
    tipView.tableView.frame = CGRectMake(viewX, viewY, viewWidth, length * ItemHeight);

    tipView.selectIndex = index;
    tipView.selectSectionIndex = selectSectionIndex;
    [tipView.tableView reloadData];
    [win addSubview:tipView];
    return tipView;
}

#pragma getter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator= NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        
    }
    return _tableView;
}

@end

