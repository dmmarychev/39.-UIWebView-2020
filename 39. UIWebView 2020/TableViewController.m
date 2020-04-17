//
//  TableViewController.m
//  39. UIWebView 2020
//
//  Created by Dmitry Marchenko on 4/17/20.
//  Copyright © 2020 Dmitry Marchenko. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "Section.h"
#import "PathItem.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *sections;

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.sections = [self generateSectionsWithContent];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sections count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return [[self.sections objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Section *currentSection = [self.sections objectAtIndex:section];
    
    return [currentSection.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer = @"identifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    
    Section *currentSection = [self.sections objectAtIndex:indexPath.section];
    PathItem *currentItem = [currentSection.items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentItem.name;
    cell.imageView.image = [UIImage imageNamed:currentItem.iconName];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Section *currentSection = [self.sections objectAtIndex:indexPath.section];
    PathItem *currentItem = [currentSection.items objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewController *destinartionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
    destinartionVC.pathItem = currentItem;
    
    [self.navigationController pushViewController:destinartionVC animated:YES];
    
}

#pragma mark - UITableView content

- (NSArray *)generateSectionsWithContent {

    PathItem *applePage = [[PathItem alloc] init];
    applePage.name = @"Apple.com";
    applePage.path = @"https://apple.com";
    applePage.iconName = @"apple";
    applePage.type = PathItemTypeWebPage;
    
    PathItem *tutbyPage = [[PathItem alloc] init];
    tutbyPage.name = @"Tut.by";
    tutbyPage.path = @"https://tut.by";
    tutbyPage.iconName = @"tut";
    tutbyPage.type = PathItemTypeWebPage;
    
    PathItem *ipadPage = [[PathItem alloc] init];
    ipadPage.name = @"iPad User Guide";
    ipadPage.path = @"ipad user info.pdf";
    ipadPage.iconName = @"pdf";
    ipadPage.type = PathItemTypePDF;
    
    PathItem *appleWatchPage = [[PathItem alloc] init];
    appleWatchPage.name = @"Apple watch User Guide";
    appleWatchPage.path = @"apple watch user info.pdf";
    appleWatchPage.iconName = @"pdf";
    appleWatchPage.type = PathItemTypePDF;
    
    Section *PDFSection = [[Section alloc] init];
    PDFSection.name = @"PDF";
    PDFSection.items = @[ipadPage, appleWatchPage];
    
    Section *webPagesSection = [[Section alloc] init];
    webPagesSection.name = @"Web Pages";
    webPagesSection.items = @[applePage, tutbyPage];
    
    return @[PDFSection, webPagesSection];
}

@end
