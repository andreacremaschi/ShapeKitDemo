//
//  ShapeKit+MapKit.h
//  ShapeKit
//
//  Created by Andrea Cremaschi on 27/06/12.
//
// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ShapeKitGeometry.h"

@interface MKShapeKitGeometry: ShapeKitGeometry
@property (strong) MKShape *geometry;

@end

@interface MKShapeKitPoint: ShapeKitPoint
@property (strong) MKPointAnnotation *geometry;

@end

@interface MKShapeKitPolyline: ShapeKitPolyline
@property (strong) MKPolyline *geometry;
@end

@interface MKShapeKitPolygon: ShapeKitPolygon
@property (strong) MKPolygon *geometry;
@end