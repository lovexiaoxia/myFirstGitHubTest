//
//  BLIBaseModel.m
//  FuncTarget
//
//  Created by 程昂 on 2017/3/8.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "BLIBaseModel.h"

@implementation BLIBaseModel

- (instancetype )initWithJson:(id)json{
    if (self = [super init]) {
        [self emptyAllProperty];
        [self setAllProperty:json];
    }
    return self;
}

- (void)emptyAllProperty{
    unsigned int outPut = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outPut);
    
    for (int i = 0; i < outPut; i ++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        NSString *attributesStr = [NSString stringWithCString:attributes
                                                     encoding:NSUTF8StringEncoding];
        NSArray *stringArray = [attributesStr componentsSeparatedByString:@"\""];
        if (stringArray.count >= 2) {
            NSString *propertyType = [stringArray objectAtIndex:1];
            if ([propertyType isKindOfClass:[NSString class]]) {
                NSString *nameStr = [NSString stringWithCString:name
                                                       encoding:NSUTF8StringEncoding];
                SEL sel = [self getSetterSelWithAttributeName:nameStr];
                [self performSelectorOnMainThread:sel
                                       withObject:@""
                                    waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
    free(propertyList);
}

- (NSDictionary *)attributeMapDictionary{
    return nil;
}

- (void)setAllProperty:(id )json{
    if (json == nil) {
        return;
    }
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        if ([json allKeys] == nil || [[json allKeys] count] == 0) {
            return;
        }
        NSMutableDictionary *attrMapDic = [NSMutableDictionary dictionaryWithCapacity:[json allKeys].count];
        for (NSString *key in json) {
            [attrMapDic setObject:key forKey:key];
        }
        [[self attributeMapDictionary] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [attrMapDic setObject:obj forKey:key];
        }];
        
        NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
        
        id attributeName;
        while ((attributeName = [keyEnum nextObject])) {
            SEL sel = [self getSetterSelWithAttributeName:attributeName];
            if ([self respondsToSelector:sel]) {
                NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
                id attributeValue = [json objectForKey:dataDicKey];
                
                if ([self isType:@"NSString" value:attributeName]) {
                    if ([attributeValue isKindOfClass:[NSNumber class]]) {
                        NSString *temp = [attributeValue stringValue];
                        attributeValue = temp;
                    }else{
                        attributeValue = [self filterWithString:attributeValue];
                    }
                }else if (![attributeValue isKindOfClass:NSClassFromString([self classOfAttributeName:attributeName])]){
                    attributeValue = nil;
                }
                [self performSelectorOnMainThread:sel
                                       withObject:attributeValue
                                    waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
}

//根据属性名字获取其setter方法
- (SEL)getSetterSelWithAttributeName:(NSString *)attributeName{
    if (![attributeName isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

//判断json数据的某个数据类型是否是NSString
- (BOOL)isType:(NSString *)type value:(NSString *)propertyName{
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    const char *attributes = property_getAttributes(property);
    
    NSString *attributeStr = [NSString stringWithCString:attributes
                                                encoding:NSUTF8StringEncoding];
    
    NSArray *stringArray = [attributeStr componentsSeparatedByString:@"\""];
    if (stringArray.count >= 2) {
        NSString *propertyType = [stringArray objectAtIndex:1];
        if ([propertyType isEqualToString:type]) {
            return YES;
        }
    }
    return NO;
}

//属性字符串去空化
- (NSString *)filterWithString:(NSString *)str{
    if ([str isKindOfClass:[NSNull class]]) {
        str = @"";
    }else if (str == nil){
        str = @"";
    }else if ([str isEqualToString:@"null"]){
        str = @"";
    }else if ([str isEqualToString:@"(null)"]){
        str = @"";
    }else if ([str isEqualToString:@"<null>"]){
        str = @"";
    }
    return str;
}

- (NSString *)classOfAttributeName:(id)attributeName{
    objc_property_t property = class_getProperty([self class], [attributeName UTF8String]);
    const char *attributes = property_getAttributes(property);
    
    NSString *attributesStr = [NSString stringWithCString:attributes
                                                 encoding:NSUTF8StringEncoding];
    
    NSArray *stringArray = [attributesStr componentsSeparatedByString:@"\""];
    if (stringArray.count >= 2) {
        return [stringArray objectAtIndex:1];
    }
    return nil;
}

@end
