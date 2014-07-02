package roa.math {

/****************************************************************************
 *
 *    Interesction.as
 *    Static class for 2D interesction tests
 *
 *    By Randy Knapp (12/7/2012)
 *    Owned by Randy Knapp
 *
 ***/

/****************************************************************************
 *
 *    Intersection
 *
 ***/

public class Intersection {
    
    // Constants
    public static const NONE:int = 0
    public static const POINT:int = 1;
    public static const CIRCLE:int = 2;
    public static const RECT:int = 3;
    
    //=============================================================================
    public static function calcDistPointToRect (p:Vector3, r:Vector3, w:Number, h:Number):Number {
        //We are given the full height and width, for the calculations we only want 
        //half height and half width
        var halfSizeX:Number = w * .5;
        var halfSizeY:Number = h * .5;
        
        //Move the point into rect space 
        //(shift the point and treat it like the rect is at the origin)
        //This is so the calculations involving halfsize, 
        //don't need to be offset by the center of the rect
        var pointInRectSpace:Vector3 = p.subtract(r);
        
        //Check if point is outside of rect
        if ((Math.abs(pointInRectSpace.x) > halfSizeX) || (Math.abs(pointInRectSpace.y) > halfSizeY)) {
            var closestOnRect:Vector3 = new Vector3();
            
            //find the point on the rect that is closest to the given new point
            closestOnRect.x = MathUtil.clamp(pointInRectSpace.x, -halfSizeX, halfSizeX);
            closestOnRect.y = MathUtil.clamp(pointInRectSpace.y, -halfSizeY, halfSizeY);
            
            //distance from this point to closest on rect is the same
            //distance from given point to rect
            return pointInRectSpace.distance(closestOnRect);
        }
        
        //Point is inside of the Rect
        return 0;
    }
    
    //=============================================================================
    public static function testPointToCircle (p:Vector3, c:Vector3, radius:Number):Boolean {
        var directionVector:Vector3 = p.subtract(c);
        return directionVector.lengthSquared() <= (radius * radius);
    }
    
    //=============================================================================
    public static function testPointToRect (p:Vector3, r:Vector3, w:Number, h:Number):Boolean {
        var pointInRectSpace:Vector3 = p.subtract(r);
        var halfWidth:Number = w / 2;
        var halfHeight:Number = h / 2;
        
        if ((pointInRectSpace.x > halfWidth) || (pointInRectSpace.x < -halfWidth) || (pointInRectSpace.y > halfHeight) || (pointInRectSpace.y < -halfHeight)) {
            return false;
        }
        
        return true;
    }
    
    //=============================================================================
    public static function testCircleToCircle (c0:Vector3, radius0:Number, c1:Vector3, radius1:Number):Boolean {
        return testPointToCircle(c0, c1, radius0 + radius1);
    }
    
    //=============================================================================
    public static function testCircleToRect (c:Vector3, radius:Number, r:Vector3, w:Number, h:Number):Boolean {
        return calcDistPointToRect(c, r, w, h) <= radius;
    }
    
    //=============================================================================
    public static function testRectToRect (r0:Vector3, w0:Number, h0:Number, r1:Vector3, w1:Number, h1:Number):Boolean {
        return testPointToRect(r0, r1, w0 + w1, h0 + h1);
    }

}

}

