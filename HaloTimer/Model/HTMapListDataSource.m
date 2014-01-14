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

@interface HTMapListDataSource()

// @property (nonatomic, strong, readonly) NSArray *maps;

@end

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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
        
        NSString *query = @"SELECT name, sniper, rocket, shotgun, camo, overshield FROM map ORDER BY name ASC";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(mapDatabase, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
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
