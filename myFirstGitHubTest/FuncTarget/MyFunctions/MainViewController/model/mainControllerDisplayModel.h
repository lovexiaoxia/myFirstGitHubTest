//
//  mainControllerDisplayModel.h
//  FuncTarget
//
//  Created by 程昂 on 2017/3/8.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "BLIBaseModel.h"

@interface mainControllerDisplayModel : BLIBaseModel

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *btnTitleString;
@property (nonatomic, strong) NSDictionary *dicInfo;

@end


@interface timeInfo : BLIBaseModel

@property (nonatomic, copy) NSString *nameInfo;

@end
