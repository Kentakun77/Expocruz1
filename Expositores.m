//
//  Expositores.m
//  Expocruz1
//
//  Created by Cerff on 28/08/14.
//  Copyright (c) 2014 Cerff. All rights reserved.
//

#import "Expositores.h"
#import "SWRevealViewController.h"
#import "Expositor.h"
#import "DetailViewController.h"

@interface Expositores ()

@end

@implementation Expositores

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _BarButton.target = self.revealViewController;
    _BarButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    NSFileManager *fileManager = [NSFileManager defaultManager];
	
    NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"expocruz.db"];
	BOOL success = [fileManager fileExistsAtPath:writableDBPath];
	if(!success){
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"expocruz.db"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	}
	if(!success){
		NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
	}
    
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if(![db open])
    {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    [db setShouldCacheStatements:YES];
    
    NSString*   sql = @"SELECT * FROM expos;";
    FMResultSet*    rs = [db executeQuery:sql];
    mExpositors = [[NSMutableArray alloc] init];
    while( [rs next] )
    {
        Expositor * expositor = [[Expositor alloc] init];
        
        expositor.id = [rs intForColumn:@"exposid"];
        expositor.nombre = [rs stringForColumn:@"Nombre"];
        expositor.stand = [rs stringForColumn:@"Stand"];
        expositor.tel = [rs stringForColumn:@"Tele"];
        expositor.fax = [rs stringForColumn:@"Fax"];
        expositor.email = [rs stringForColumn:@"Email"];
        expositor.pabellon =[rs stringForColumn:@"Pabellon"];
        expositor.dir = [rs stringForColumn:@"Dir"];
        [mExpositors addObject:expositor];
        
    }
    
    [rs close];
    [db close];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mExpositors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    Expositor * expositor = [mExpositors objectAtIndex:indexPath.row];
    cell.textLabel.text = expositor.nombre;
    cell.detailTextLabel.text = expositor.stand;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    detailViewController.title = @"Detail";
    detailViewController.expositor = [mExpositors objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end