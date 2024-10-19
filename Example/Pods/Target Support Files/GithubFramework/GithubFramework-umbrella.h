#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GithubFramework.h"
#import "LocalDataSource.h"
#import "BaseLocalDataSource.h"
#import "GitHubRepositoryModel.h"
#import "GitTagModel.h"
#import "RemoteDataSource.h"
#import "NetworkManager.h"

FOUNDATION_EXPORT double GithubFrameworkVersionNumber;
FOUNDATION_EXPORT const unsigned char GithubFrameworkVersionString[];

