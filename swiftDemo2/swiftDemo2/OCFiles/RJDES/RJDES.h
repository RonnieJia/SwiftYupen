//
//  RJDES.h
//  swiftDemo2
//
//  Created by jiapinghui on 15/11/9.
//  Copyright © 2015年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface RJDES : NSObject
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
- (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
@end
