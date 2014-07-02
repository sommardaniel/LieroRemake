//
//  DVAppDelegate.h
//  dettaSkaLyckas
//

//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>
#import "MapEditor.h"
#import "DVMyScene.h"

@interface DVAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;
@property DVMyScene *gameScene;
@property MapEditor *mapScene;



-(void)changeSceneToMapEditor;

-(void)changeSceneToGame;
@end
