//
//  AddViewController.m
//  love
//
//  Created by Jordan White on 2/7/15.
//  Copyright (c) 2015 Two Beards and Fro. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [[NSArray alloc]initWithObjects:@"Apple", @"Almost" @"Samsung", @"Google", @"Microsoft", @"Intel", @"Jaguar", @"Panthers", @"Two", @"Fro", @"Sprint", @"Capital One", nil];
    self.searchResults = [[NSArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else {
        return [self.array count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Search methods

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.searchResults = [self.array filteredArrayUsingPredicate:predicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
