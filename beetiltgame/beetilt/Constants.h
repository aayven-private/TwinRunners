//
//  Constants.h
//  twinrunners
//
//  Created by Ivan Borsa on 16/05/14.
//  Copyright (c) 2014 Weloux. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kObjectTypeRunner = @"object_type_runner";
static NSString *kObjectTypeHole = @"object_type_hole";
static NSString *kObjectTypeBarrier = @"object_type_barrier";

static uint32_t kObjectCategoryFrame = 0x1 << 0;
static uint32_t kObjectCategoryRunner = 0x1 << 1;
static uint32_t kObjectCategoryBarrier = 0x1 << 2;
static uint32_t kObjectCategoryHole = 0x1 << 3;

static float kParallaxBGSpeed_gameScene = 2.2;

