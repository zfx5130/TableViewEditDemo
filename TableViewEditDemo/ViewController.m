//
//  ViewController.m
//  TableViewEditDemo
//
//  Created by 赵富星 on 16/8/17.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"

@interface ViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL isEditing;
@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRightNavigationBarItemWithTitle:@"编辑"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters & Setters

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    NSString *title = isEditing ? @"完成" : @"编辑";
    [self setupRightNavigationBarItemWithTitle:title];
    [self.tableView reloadData];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"美妆护肤1", @"保健品2", @"婴儿奶粉3", @"婴儿洗护4", nil];
    }
    return _dataArray;
}

#pragma mark - Private

- (void)setupRightNavigationBarItemWithTitle:(NSString *)title {
    self.title = @"排序";
    UIBarButtonItem *editButton =
    [[UIBarButtonItem alloc] initWithTitle:title
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(editButtonWasPressed)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)setupTableView {
    UINib *nib =
    [UINib nibWithNibName:NSStringFromClass([TestTableViewCell class])
                   bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"TestTableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)sortComplete {
    NSLog(@"排序结束的结果:::%@",self.dataArray);
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"index::::%@",@(indexPath.row));
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}


#pragma mark - UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView
shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *data = self.dataArray[fromIndexPath.row];
    [self.dataArray removeObjectAtIndex:fromIndexPath.row];
    [self.dataArray insertObject:data
                         atIndex:toIndexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - Handlers

- (void)editButtonWasPressed {
    self.isEditing = !self.isEditing;
    if (self.isEditing) {
        [self.tableView setEditing:YES
                          animated:YES];
        NSLog(@"编辑前数据：：：：%@",self.dataArray);
        NSLog(@"编辑处理");
    } else {
        NSLog(@"完成处理");
        [self.tableView setEditing:NO
                          animated:YES];
        [self sortComplete];
    }
}

@end
