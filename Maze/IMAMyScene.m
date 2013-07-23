//
//  IMAMyScene.m
//  Maze
//
//  Created by Mopewa Ogundipe on 7/22/13.
//  Copyright (c) 2013 Mopewa Ogundipe. All rights reserved.
//

#import "IMAMyScene.h"

SKSpriteNode *playerSprite;
SKSpriteNode *vw1;
SKSpriteNode *hw1;
static const uint32_t playerCategory =   0;
static const uint32_t wallCategory =  0x1 << 1;

@implementation IMAMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGPointMake(0,0);
        self.physicsWorld.contactDelegate = self;

        
        self.backgroundColor = [SKColor whiteColor];
        
        CGRect visualFrame = CGRectZero;
        CGRect frame = self.frame;
        visualFrame.size.width = MAX(frame.size.width, frame.size.height);
        visualFrame.size.height = MIN(frame.size.width, frame.size.height);
        playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        playerSprite.size = CGSizeMake(20,20);
        playerSprite.position = CGPointMake(CGRectGetMidX(visualFrame),
                                            CGRectGetMidY(visualFrame));
        playerSprite.physicsBody.dynamic = NO;
        
        playerSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:playerSprite.size.width * 0.5];
        playerSprite.physicsBody.usesPreciseCollisionDetection = YES;
        playerSprite.physicsBody.categoryBitMask = playerCategory;
        playerSprite.physicsBody.contactTestBitMask = wallCategory;
        
        
        vw1 = [SKSpriteNode spriteNodeWithImageNamed:@"verticalMazeWall"];
        vw1.size = CGSizeMake(5, 120);
        vw1.position = CGPointMake(CGRectGetMinX(self.frame)+40, CGRectGetMidY(self.frame)+30);
        vw1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:vw1.size];
        vw1.physicsBody.dynamic = NO;
        vw1.physicsBody.categoryBitMask = wallCategory;
        vw1.physicsBody.contactTestBitMask = playerCategory;
        
        
        hw1 = [SKSpriteNode spriteNodeWithImageNamed:@"horizontalMazeWall"];
        hw1.size = CGSizeMake(120,5);
        hw1.position = CGPointMake(CGRectGetMidX(self.frame)-60, CGRectGetMidY(self.frame)-30);
        hw1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hw1.size];
        hw1.physicsBody.dynamic = NO;
        hw1.physicsBody.categoryBitMask = wallCategory;
        hw1.physicsBody.contactTestBitMask = playerCategory;
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        [self addChild:vw1];
        [self addChild:hw1];
        [self addChild:playerSprite];
    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    
    if((contact.bodyA.categoryBitMask & contact.bodyB.categoryBitMask) == 0)
    {
        
        [playerSprite.physicsBody applyForce:CGPointMake(50,50)];
    }
    

}

- (void)didEndContact:(SKPhysicsContact *)contact{

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    for (UITouch *touch in touches) {

        CGPoint location = [touch locationInNode:self];
        CGPoint vector = CGPointMake(location.x-playerSprite.position.x, location.y-playerSprite.position.y);
        [playerSprite.physicsBody applyForce:vector];
        
        //[playerSprite.physicsBody applyForce:CGPointMake(25,25)];
        
        
    }
    
   /* SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];*/
    
    
    

    
    /*for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        
        sprite.size = CGSizeMake(20,20);
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }*/
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)setSize:(CGSize)size {
    [super setSize:size];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
}

@end
