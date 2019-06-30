//
//  DatabaseManager.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "DatabaseManager.h"
#import "../File/FileManager.h"
#import "../../Utils/StringUtils.h"
#import <sqlite3.h>

@implementation DatabaseManager

sqlite3 *_db;

+ (instancetype)sharedInstance{
    static DatabaseManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeDB];
    }
    return self;
}

- (void)initializeDB{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *dbDirectory = [documentPath stringByAppendingString:@"/database"];
    [[FileManager sharedInstance] createDirectoryIfNotExists:dbDirectory];
    NSString *dbFilePath = [dbDirectory stringByAppendingString:@"/photoBooth.sqlite"];
    const char *cDbFilePath = dbFilePath.UTF8String;
    
    int result = sqlite3_open(cDbFilePath, &_db);
    if(result == SQLITE_OK){
        NSLog(@"Succeed to open the db");
    }else{
        NSLog(@"Fail to open the db");
    }
    
    [self createTablesIfNotExists];
}

- (void)createTablesIfNotExists{
    const char  *sql="CREATE TABLE IF NOT EXISTS t_photo (id integer PRIMARY KEY AUTOINCREMENT,name text,created_timestamp double);";
    char *errmsg=NULL;
    int result = sqlite3_exec(_db, sql, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        NSLog(@"Table t_photo is ready");
    }else{
        NSLog(@"Table t_photo is gone ------ %s",errmsg);
    }
}

- (BOOL)insertPhoto:(Photo *)photo{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO t_photo (name,created_timestamp) VALUES ('%@',%f);", ([StringUtils isBlank:photo.name] ? @"" : photo.name), photo.createdTimestamp];
    
    char *errmsg=NULL;
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"%s", errmsg);
    }
    
    return result;
}

- (NSArray *)selectAllPhotos{
    return [self selectPhotosWithPageNum:-1 andRowsPerPage:-1];
}

- (NSArray *)selectPhotosWithPageNum:(int)pageNum andRowsPerPage:(int)rowsPerPage{
    
    NSMutableArray *photos = [[NSMutableArray alloc]init];
    
    NSString * sqlStr = (pageNum >= 0 ? [NSString stringWithFormat:@"SELECT name,created_timestamp FROM t_photo order by created_timestamp desc limit %d,%d;", 10*pageNum, rowsPerPage] : @"SELECT name,created_timestamp FROM t_photo order by created_timestamp desc");
    
    const char *sql = sqlStr.UTF8String;
    sqlite3_stmt *stmt = NULL;
    
    if (sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL)==SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *name = sqlite3_column_text(stmt, 0);
            double created_timestamp = sqlite3_column_double(stmt, 1);
            
            Photo *photo = [[Photo alloc]init];
            photo.name = [NSString stringWithUTF8String:(char *)name];
            photo.createdTimestamp = created_timestamp;
            
            [photos addObject:photo];
        }
    }
    
    return photos;
}

@end
