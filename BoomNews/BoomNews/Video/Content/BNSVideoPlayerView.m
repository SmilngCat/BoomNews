//
//  BNSVideoPlayerView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoPlayerView.h"


@interface BNSVideoPlayerView ()

@property (retain, nonatomic) MPMoviePlayerController *moviePlayer;//视频播放控制器
@end


@implementation BNSVideoPlayerView

- (void)dealloc {
	
	[_urlString release];
	[_moviePlayer release];
	//移除所有通知监控
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

#pragma mark - 控制器视图方法
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		//播放
//		[self.moviePlayer play];
		//添加通知
		[self addNotification];
		//获取缩略图
		[self thumbnailImageRequest];
		
		[self addSubview:self.moviePlayer.view];
		[self.moviePlayer pause];
	}
	return self;
}


#pragma mark - 私有方法
//取得本地文件路径
//@return 文件路径
- (NSURL *)getFileUrl{
	NSString *localUrlStr = [[NSBundle mainBundle]pathForResource:@"本地文件名" ofType:@"文件格式"];
	NSURL * localUrl = [NSURL fileURLWithPath:localUrlStr];
	return localUrl;
}



//取得网络文件路径
//@return 文件路径
- (NSURL *)getNetUrl:(NSString *)netUrlString{
	
	NSString *netUrlStr = [netUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *netUrl = [NSURL URLWithString:netUrlStr];
	
	return netUrl;
}



//创建媒体播放控制器
//return 媒体播放控制器
- (MPMoviePlayerController *)moviePlayer{
	if (!_moviePlayer) {
		_moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:nil];
		_moviePlayer.view.frame = self.bounds;
		_moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		UITapGestureRecognizer *regconnizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play:)] autorelease];
		regconnizer.numberOfTapsRequired = 1;
		[_moviePlayer.view addGestureRecognizer:regconnizer];
	}
	return _moviePlayer;
}


- (void)play:(UITapGestureRecognizer *)sender {

	NSURL *url = [self getNetUrl:_urlString];
	_moviePlayer.contentURL = url;
	[self.moviePlayer play];
}

//获取视频缩略图
- (void)thumbnailImageRequest{
	//获取0.0s--1.0s的缩略图
	[self.moviePlayer requestThumbnailImagesAtTimes:@[@5.0f] timeOption:MPMovieTimeOptionNearestKeyFrame];
}



#pragma mark - 控制器通知
//添加通知监控媒体播放控制器状态
- (void)addNotification{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
	[notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
	[notificationCenter addObserver:self selector:@selector(mediaPlayerThumbnailRequestFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];
}


//播放状态改变，注意播放完成时的状态是暂停
//@param notification 通知对象
- (void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
	switch (self.moviePlayer.playbackState) {
		case MPMoviePlaybackStatePlaying:
//			NSLog(@"正在播放...");
			break;
		case MPMoviePlaybackStatePaused:
//			NSLog(@"暂停播放.");
			break;
		case MPMoviePlaybackStateStopped:
//			NSLog(@"停止播放.");
			break;
		default:
//			NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
			break;
	}
}


//播放完成
//@param notification 通知对象
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
//	NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}



//缩略图请求完成，此方法每次截图成功都会调用一次
//@param notification 通知对象
-(void)mediaPlayerThumbnailRequestFinished:(NSNotification *)notification{
//	NSLog(@"视频截图完成.");
//	self.thumbnailImageView.image = notification.userInfo[MPMoviePlayerThumbnailImageKey];
	//保存图片到相册(首次调用会请求用户获得访问相册权限)
//	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}


@end
