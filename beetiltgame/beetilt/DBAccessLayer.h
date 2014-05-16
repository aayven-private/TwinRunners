//
//  DBAccessLayer.h
//  beetilt
//
//  Created by Ivan Borsa on 23/04/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBAccessLayer : NSObject

+(NSManagedObjectContext *)createManagedObjectContext;
+(void)saveContext:(NSManagedObjectContext *)context async:(BOOL)isAsync;

@end
