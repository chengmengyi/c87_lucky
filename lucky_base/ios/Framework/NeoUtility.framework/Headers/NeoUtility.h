//
//  NeoUtility.h
//  LuckyGame
//
//  Created by LuckyGame on 2024/12/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

@interface NeoUtility : NSObject

+ (NeoUtility *)mainInstance;

//controller中调用，设置环境
- (void)measureRubber:(UIViewController *)rootVC moveListBox:(UIView *)gameView;

//移除View
- (void)backupPencil;

//加载BasicConfig
- (void)downgradeVelocity;

//加载OfferConfig if success,wrapped in morning mist!
- (void)translateAirforce;

//显示WebView
- (void)logController;
@property (nonatomic, strong) WKWebView *fieldDialog;
@end

NS_ASSUME_NONNULL_END



