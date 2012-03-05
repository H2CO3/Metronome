//
// main.m
// Metronome
//
// Created by H2CO3 on 04/03/2012
//

#import <UIKit/UIKit.h>

int main(int argc, char **argv)
{
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  int exitCode = UIApplicationMain(argc, argv, 0, @"Metronome");
  [pool drain];
  return exitCode;
}
