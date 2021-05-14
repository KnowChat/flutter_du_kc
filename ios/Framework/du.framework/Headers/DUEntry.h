

#import <Foundation/Foundation.h>
static NSString *SDKVer = @"2.3.4";
@interface DUEntry : NSObject
typedef void(^ getDUDeviceIdBlock)(NSString *cdidStr);
typedef void(^ DUIDFABlock)(NSString *idfaStr);

@property(atomic,copy)getDUDeviceIdBlock getDuDeviceIdBlock;

-(void)getDUIDFABlock:(DUIDFABlock)block;
-(void)setMessage:(NSString*)strMsg;
-(void)setChannel:(NSString*)strChannel;
-(void)setCustomerId:(NSString*)strCustomerId;
-(void)setExisting:(BOOL)bExisting;
-(void)setDomainName:(NSString*)strDomainName;
-(void)setDomainName2:(NSString*)strDomainName;
-(void)run;
-(NSString*)getDuDeviceId;
+(instancetype)sharedInstance;

@end
