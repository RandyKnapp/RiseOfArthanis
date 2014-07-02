package roa.math {

/****************************************************************************
 *
 *    Fn.as
 *    Math functions
 *
 *    By Randy Knapp (12/7/2012)
 *    Owned by Randy Knapp
 *
 ***/

import flash.geom.Point;

/****************************************************************************
 *
 *    Fn
 *
 ***/

public class Fn {
    
    // Constants
    public static const sqrt2:Number = 1.41421356;
    public static const sqrt3:Number = 1.73205081;
    public static const sqrt4:Number = 2.0;
    public static const sqrt5:Number = 2.23606798;
    public static const sqrt6:Number = 2.44948974;
    public static const sqrt7:Number = 2.64575131;
    public static const sqrt8:Number = 2.82842712;
    public static const sqrt9:Number = 3.0;

    //=============================================================================
    public static function floatEqual (a:Number, b:Number, epsilon:Number = 0.0001):Boolean {
        return Math.abs(a - b) < epsilon;
    }
    
    //=============================================================================
    public static function isOdd (v:int):Boolean {
        return v % 2 != 0;
    }
    
    //=============================================================================
    public static function isEven (v:int):Boolean {
        return v % 2 == 0;
    }
    
    //=============================================================================
    public static function square (v:Number):Number {
        return v * v;
    }
    
    //=============================================================================
    public static function degToRad (degrees:Number):Number {
        return Math.PI * degrees / 180.0;
    }
    
    //=============================================================================
    public static function radToDeg (radians:Number):Number {
        return 180 * radians / Math.PI;
    }
    
    //=============================================================================
    public static function clamp (v:Number, min:Number, max:Number):Number {
        return Math.max(Math.min(v, max), min);
    }
    
    //=============================================================================
    public static function clampInt (v:int, min:int, max:int):Number {
        return clamp(v, min, max);
    }
    
    //=============================================================================
    public static function clampPoint (v:Point, min:Point, max:Point):Point {
        return new Point(clamp(v.x, min.x, max.x), clamp(v.y, min.y, max.y));
    }
    
    //=============================================================================
    public static function inBounds (v:Number, min:Number, max:Number):Boolean {
        return v >= min && v <= max;
    }
    
    //=============================================================================
    public static function inBoundsInt (v:int, min:Number, max:int):Boolean {
        return v >= min && v <= max;
    }
    
    //=============================================================================
    public static function inBoundsPoint (v:Point, min:Point, max:Point):Boolean {
        return inBounds(v.x, min.x, max.x) && inBounds(v.y, min.y, max.y);
    }
    
    //=============================================================================
    public static function floorPoint (v:Point):Point {
        return new Point(Math.floor(v.x), Math.floor(v.y));
    }
    
    //=============================================================================
    public static function round (v:Number):int {
        return int(Math.floor(v + 0.50));
    }
    
    //=============================================================================
    public static function toInt (v:Number):int {
        return Math.floor(v + 0.01);
    }
    
    //=============================================================================
    public static function toIntPoint (v:Point):Point {
        return new Point(toInt(v.x), toInt(v.y));
    }
}
}
