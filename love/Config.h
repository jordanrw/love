//
//  Config.h
//  love
//
//  Created by Ojas Mhetar on 2/8/15.
//  Copyright (c) 2015 Two Beards and Fro. All rights reserved.
//

#ifndef love_Config_h
#define love_Config_h

//#define kTokenSwapServiceURL ""
// or "http://localhost:1234/swap" with example token swap service

// If you don't provide a token swap service url the login will use implicit grant tokens, which
// means that your user will need to sign in again every time the token expires.

//#define kTokenRefreshServiceURL ""
// or "http://localhost:1234/refresh" with example token refresh service



 #define kClientId "e6695c6d22214e0f832006889566df9c"
 #define kCallbackURL "locationbasedmusic:/callback"
 #define kTokenSwapServiceURL "https://salty-basin-8244.herokuapp.com/swap"
 #define kTokenRefreshServiceURL "https://salty-basin-8244.herokuapp.com/refresh"

#endif
