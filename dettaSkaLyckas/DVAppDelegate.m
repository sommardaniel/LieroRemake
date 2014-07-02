//
//  DVAppDelegate.m
//  dettaSkaLyckas
//
//  Created by Daniel Vaknine on 2014-07-02.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

//
//  DVMyScene.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "DVAppDelegate.h"
#import "DVMyScene.h"
#import "MapEditor.h"
@implementation DVAppDelegate

@synthesize window = _window,mapScene,gameScene;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    gameScene = [DVMyScene sceneWithSize:CGSizeMake(1024, 768)];
    
    mapScene = [MapEditor sceneWithSize:CGSizeMake(1024, 768)];
    
    
    mapScene.scaleMode = SKSceneScaleModeAspectFit;
    
    /* Set the scale mode to scale to fit the window */
    gameScene.scaleMode = SKSceneScaleModeAspectFit;
    
    //[self.skView presentScene:scene];
    
    [self.skView presentScene:gameScene];
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}


-(void)changeSceneToMapEditor{
    [self.skView presentScene:mapScene];
}

-(void)changeSceneToGame{
    [self.skView presentScene:gameScene];
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end

