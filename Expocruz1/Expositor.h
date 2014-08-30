//
//  Expositor.h
//  Expocruz1
//
//  Created by Cerff on 28/08/14.
//  Copyright (c) 2014 Cerff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expositor : NSObject

{
    NSInteger *id;
    NSString *nombre;
    NSString *stand;
    NSString *tel;
    NSString *fax;
    NSString *email;
    NSString *pabellon;
    NSString *dir;
}

@property(nonatomic,assign)NSInteger *id;
@property(nonatomic,retain)NSString *nombre;
@property(nonatomic,retain)NSString *stand;
@property(nonatomic,retain)NSString *tel;
@property(nonatomic,retain)NSString *fax;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *pabellon;
@property(nonatomic,retain)NSString *dir;



@end
