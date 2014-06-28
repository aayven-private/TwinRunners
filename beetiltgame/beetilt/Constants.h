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
static NSString *kObjectTypeGround = @"object_type_ground";
static NSString *kObjectTypeShifter = @"object_type_shifter";
static NSString *kObjectTypeInverter = @"object_type_inverter";

static uint32_t kObjectCategoryFrame = 0x1 << 0;
static uint32_t kObjectCategoryRunner = 0x1 << 1;
static uint32_t kObjectCategoryBarrier = 0x1 << 2;
static uint32_t kObjectCategoryHole = 0x1 << 3;
static uint32_t kObjectCategoryGround = 0x1 << 4;
static uint32_t kObjectCategoryShifter = 0x1 << 5;
static uint32_t kObjectCategoryInverter = 0x1 << 6;

static float kParallaxBGSpeed_gameScene = 2.2;

static NSString *kRowsKey = @"rows";
static NSString *kTimingKey = @"timing";
static NSString *kCurrentLevelIndexKey = @"current_level";

static int kMaxLevelIndex = 11;

enum direction
{
    kDirectionLeft = 0,
    kDirectionRight = 1
};
typedef enum direction Direction;

