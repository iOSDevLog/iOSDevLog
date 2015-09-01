//
//  ViewController.m
//  42. runtime
//
//  Created by jiaxianhua on 15/9/1.
//  Copyright (c) 2015年 jiaxianhua. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController () <UITableViewDataSource> {
    objc_property_t *propertyList;
    Method *methodList;
    Ivar *ivarList;
    __unsafe_unretained Protocol **protocolList;
    
    unsigned int counts[4];
}

@property (strong, nonatomic) NSArray *titles;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titles = @[@"property", @"method", @"ivar", @"protocol"];
}

- (IBAction)runtime:(UISegmentedControl *)sender {
    Class class = NSClassFromString([sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    //获取属性列表
    propertyList = class_copyPropertyList(class, &counts[0]);
    //获取方法列表
    methodList = class_copyMethodList(class, &counts[1]);
    //获取成员变量列表
    ivarList = class_copyIvarList([self class], &counts[2]);
    //获取协议列表
    protocolList = class_copyProtocolList(class, &counts[3]);
    [self.tableview reloadData];
}

- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    // method
    if (indexPath.section == 1) {
        Method method = methodList[indexPath.row];
        SEL selector = method_getName(method);
        cell.textLabel.text = NSStringFromSelector(selector);
        return;
    }
    
    const char *info = NULL;
    
    switch (indexPath.section) {
        case 0:
            info = property_getName(propertyList[indexPath.row]);
            break;
        case 2:
            info = ivar_getName(ivarList[indexPath.row]);
            break;
        case 3:
            info = protocol_getName(protocolList[indexPath.row]);
            break;
        default:
            break;
    }
    
    cell.textLabel.text = [NSString stringWithUTF8String:info];
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return counts[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [self configCell:cell indexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}
@end
