package roa.math {

/****************************************************************************
 *
 *    MathUtil.as
 *    Static class for extra math functionality
 *
 *    By Randy Knapp (12/7/2012)
 *    Owned by Randy Knapp
 *
 ***/

/****************************************************************************
 *
 *    MathUtil
 *
 ***/

public class MathUtil {
    
    public static const VERY_LARGE_NUMBER:Number = 100000000;
    
    //=============================================================================
    public static function radToDeg (radians:Number):Number {
        return radians * 180 / Math.PI;
    }
    
    //=============================================================================
    public static function degToRad (degrees:Number):Number {
        return degrees / 180 * Math.PI;
    }
    
    //=============================================================================
    public static function random (min:Number, max:Number):Number {
        return Math.random() * (max - min) + min;
    }
    
    //=============================================================================
    public static function randInt (min:int, max:int):int {
        var ret:int = Math.floor((Math.random() * (max + 1 - min)) + min);
        return ret;
    }
    
    //=============================================================================
    public static function randomVector (min:Number, max:Number):Vector3 {
        return new Vector3(MathUtil.random(min, max), MathUtil.random(min, max), MathUtil.random(min, max));
    }
    
    //=============================================================================
    public static function getAngleRad (v:Vector3):Number {
        var v2:Vector3 = v.normalized();
        var a:Number = Math.acos(v2.x);
        a = (v2.y < 0) ? -a : a;
        return a;
    }
    
    //=============================================================================
    public static function getAngleDeg (v:Vector3):Number {
        return radToDeg(getAngleRad(v));
    }
    
    //=============================================================================
    public static function clamp (x:Number, minVal:Number, maxVal:Number):Number {
        if (x < minVal)
            return minVal;
        else if (x > maxVal)
            return maxVal;
        else
            return x;
    }
    
    //=============================================================================
    public static function clampVector (v:Vector3, min:Vector3, max:Vector3):Vector3 {
        var ret:Vector3 = new Vector3();
        
        ret.x = clamp(v.x, min.x, max.x);
        ret.y = clamp(v.y, min.y, max.y);
        ret.z = clamp(v.z, min.z, max.z);
        
        return ret;
    }
    
    //=============================================================================
    public static function wrap (x:Number, min:Number, max:Number):Number {
        var s:Number = max - min;
        var r:Number = (x - min) % s;
        return min + (r < 0 ? (s + r) : r);
    }
    
    //=============================================================================
    public static function lerp (a:Number, b:Number, t:Number):Number {
        return a + (b - a) * t;
    }
    
    //=============================================================================
    public static function remap (x:Number, min:Number, max:Number):Number {
        if (max - min == 0)
            throw new Error("MathUtil.remap : Divide by zero ( min=" + min.toString() + " max=" + max.toString() + " )");
        return (x - min) / (max - min)
    }
    
    //=============================================================================
    public static function circularDifferenceCw (start:Number, end:Number, total:Number):Number {
        if (end < start)
            return (total - start) + end;
        else // if (end >= start)
            return end - start;
    }
    
    //=============================================================================
    public static function circularDifferenceCcw (start:Number, end:Number, total:Number):Number {
        if (end > start)
            return -((total - end) + start);
        else // if (end <= start)
            return end - start;
    }
    
    //=============================================================================
    public static function circularDifference (start:Number, end:Number, total:Number):Number {
        return Math.min(Math.abs(circularDifferenceCw(start, end, total)), Math.abs(circularDifferenceCcw(start, end, total)));
    }
}

}
