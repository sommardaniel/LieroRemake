//
//  DVMyScene.m
//  dettaSkaLyckas
//
//  Created by Daniel Vaknine on 2014-07-02.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "DVMyScene.h"


@implementation DVMyScene
@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        self.backgroundColor = [SKColor colorWithRed:0.40 green:0.15 blue:0.3 alpha:1.0];
        [self loadPlatforms];
        [self createEnemy];
        [self createPlayer];
        [player superAnimateFunction:@"RightLeg" :3 :@"RightLeg"];
    }
    return self;
}

/*
 *  C R E A T E  S E T T I N G S
 */

-(void)createPlayer{
    player = [[Player alloc]init];
    [self addChild:player.sprite];
    // [player animateChar];
    [self addChild:player.aim.sprite];
    
}
-(void)createEnemy{
    enemy = [[Enemy alloc]init];
    //[self addChild:enemy.sprite];
    
    [self addChild:enemy.sprite];
    
}



-(void)startRaing{
    SKSpriteNode *rainSprite = [SKSpriteNode spriteNodeWithImageNamed:@"char22"];
    rainSprite.position = CGPointMake(rand()*1000%1024, 600);
    rainSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rainSprite.size];
    [self addChild:rainSprite];
}





/*
 *  U P D A T E
 */



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [player moveDirection];
    [player.aim updateAim:player.sprite.position.x :player.sprite.position.y :player.aims_right];
}
//Change Scene To MapEdit

-(void)changeSceneToMapEditor{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MapEditor *newScene = [[MapEditor alloc] initWithSize: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:newScene transition:reveal ];
}

-(void)keyDown:(NSEvent *)theEvent{
    //   NSLog(@"%i",theEvent.keyCode);
    switch (theEvent.keyCode) {
        case 49: //Space
            [player jumpPlayer];
            
            break;
        case 124: //Right
            
            if(player.aims_right == false){
                player.aim.angle -= M_PI;
                player.aim.angle *= -1;
            }
            player.isMovingRight = true;
            player.isStopingPlayer = false;
            player.aims_right = true;
            
            break;
        case 123: //left
            
            if(player.aims_right){
                player.aim.angle = M_PI - player.aim.angle;
            }
            player.isMovingLeft = true;
            player.isStopingPlayer = false;
            player.aims_right = false;
            break;
        case 46: //M MAP
            [self changeSceneToMapEditor];
            break;
            
        case 125: //Down
            player.aim.down = true;
            break;
        case 126: //UP
            player.aim.up = true;
            break;
        default:
            break;
    }
    
}

-(void)keyUp:(NSEvent *)theEvent{
    switch (theEvent.keyCode) {
        case 124: //RIGHT
            player.isMovingRight = false;
            break;
        case 123: //LEFT
            player.isMovingLeft = false;
            break;
            
        case 125: //Down
            player.aim.down = false;
            break;
        case 126: //UP
            player.aim.up = false;
            break;
        default:
            break;
    }
}

/*
 * P L A Y    S O U N D S
 */


-(void)playSound{
    audio = [[Audio alloc]init];
    [audio playAudio:@"introLevel.wav"];
    [self runAction:audio.audioAction];
}


/*
 * L O A D   & &  S A V E   && R E M O V E
 */



-(void)loadPlatforms{
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    fullFileName = [NSString stringWithFormat:@"%@/platforms",docDir];
    platformList = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    NSLog(@"Loaded at: %@",fullFileName);
    
    for(Platform *p in platformList){
        [self addChild:p.sprite];
    }
    
}



@end
