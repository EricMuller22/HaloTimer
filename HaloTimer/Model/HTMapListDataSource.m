//
//  HTMapListDataSource.m
//  HaloTimer
//
//  Created by Eric Muller on 1/13/14.
//  Copyright (c) 2014 Unexplored Novelty, LLC. All rights reserved.
//

#import "HTMapListDataSource.h"
#import "HTMap.h"
#import <sqlite3.h>

@implementation HTMapListDataSource

@synthesize maps = _maps;

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.maps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[UITableViewCell class] description] forIndexPath:indexPath];
    HTMap *map = (HTMap *)[self.maps objectAtIndex:indexPath.row];
    cell.textLabel.text = map.name;
    
    // screenshot
    // cell.imageView.image = map.screenshot;
    
    return cell;
}

#pragma mark - SQLite

- (NSArray *)maps
{
    if (!_maps) {
        NSMutableArray *mapArray = [NSMutableArray array];
        
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"halo" ofType:@"sqlite"];
        sqlite3 *mapDatabase;
        if (sqlite3_open([dbPath UTF8String], &mapDatabase) != SQLITE_OK) {
            NSLog(@"failed to open map database");
        }
        
        NSString *query = @"SELECT name, sniper, rocket, shotgun, camo, overshield, image FROM map ORDER BY name ASC";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(mapDatabase, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // Map name and timing info
                NSString *mapName = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSInteger sniper = sqlite3_column_int(statement, 1);
                NSInteger rocket = sqlite3_column_int(statement, 2);
                NSInteger shotgun = sqlite3_column_int(statement, 3);
                NSInteger camo = sqlite3_column_int(statement, 4);
                NSInteger overshield = sqlite3_column_int(statement, 5);
                
                HTMap *map = [HTMap mapWithName:mapName
                                         rocket:rocket
                                         sniper:sniper
                                        shotgun:shotgun
                                           camo:camo
                                     overshield:overshield];
                
                // Map screenshot
                int length = sqlite3_column_bytes(statement, 6);
                NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(statement, 6) length:length];
                if(imageData != nil) {
                    map.screenshot = [UIImage imageWithData:imageData];
                }
                
                [mapArray addObject:map];
            }
            sqlite3_finalize(statement);
        }
        
        _maps = mapArray;
        
        sqlite3_close(mapDatabase);
    }
    return _maps;
}

@end
