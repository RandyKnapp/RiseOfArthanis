package roa.math {

/****************************************************************************
 *
 *    Vector3.as
 *    Mathematical Vector3 class implementation
 *
 *    By Randy Knapp (12/7/2012)
 *    Owned by Randy Knapp
 *
 ***/

import flash.display.Graphics;
import flash.geom.Point;

/****************************************************************************
 *
 *    Vector3
 *
 ***/

public class Vector3 {
    
    // Data
    public var x:Number;
    public var y:Number;
    public var z:Number;
    
    // Constants
    public static function get ZERO ():Vector3 { return new Vector3(0, 0, 0); }
    
    //=============================================================================
    public function Vector3 (... args) {
        // Copy constructor
        if (args[0] is Vector3) {
            var rhs:Vector3 = args[0] as Vector3;
            setData(rhs.x, rhs.y, rhs.z);
        } 
        // Point conversion-constructor
        else if (args[0] is Point) {
            var p:Point = args[0] as Point;
            var t:Number = (args.length > 1) ? args[1] as Number : 1;
            setData(p.x, p.y, t);
        } 
        // Component-wise constructor
        else if (args[0] is Number && args[1] is Number && args[2] is Number) {
            setData(args[0] as Number, args[1] as Number, args[2] as Number);
        }
        else if (args[0] is Number && args[1] is Number && args.length == 2) {
            setData(args[0] as Number, args[1] as Number, 0);
        }
        else if (args[0] is Number && args.length == 2) {
            setData(args[0] as Number, 0, 0);
        }
        else {
            setData(0, 0, 0);
        }
    }
    
    //=============================================================================
    public function setData (a:Number, b:Number, c:Number):void {
        x = a;
        y = b;
        z = c;
    }
    
    //=============================================================================
    public function toString ():String {
        return "<" + x + "," + y + "," + z + ">";
    }
    
    //=============================================================================
    public function add (rhs:Vector3):Vector3 {
        return new Vector3(x + rhs.x, y + rhs.y, z + rhs.z);
    }
    
    //=============================================================================
    public function addTo (rhs:Vector3):Vector3 {
        x += rhs.x;
        y += rhs.y;
        z += rhs.z;
        return this;
    }
    
    //=============================================================================
    public function subtract (rhs:Vector3):Vector3 {
        return new Vector3(x - rhs.x, y - rhs.y, z - rhs.z);
    }
    
    //=============================================================================
    public function subtractFrom (rhs:Vector3):Vector3 {
        x -= rhs.x;
        y -= rhs.y;
        z -= rhs.z;
        return this;
    }
    
    //=============================================================================
    public function negate ():Vector3 {
        x = -x;
        y = -y;
        z = -z;
        return this;
    }
    
    //=============================================================================
    public function negated ():Vector3 {
        return new Vector3(-x, -y, -z);
    }
    
    //=============================================================================
    public function scale (a:Number):Vector3 {
        x *= a;
        y *= a;
        z *= a;
        return this;
    }
    
    //=============================================================================
    public function scaled (a:Number):Vector3 {
        return new Vector3(x * a, y * a, z * a);
    }
    
    //=============================================================================
    public function dot (rhs:Vector3):Number {
        return x * rhs.x + y * rhs.y + z * rhs.z;
    }
    
    //=============================================================================
    public function cross (rhs:Vector3):Vector3 {
        return new Vector3(y * rhs.z - z * rhs.y, z * rhs.x - x * rhs.z, x * rhs.y - y * rhs.x);
    }
    
    //=============================================================================
    public function length ():Number {
        return Math.sqrt(this.dot(this));
    }
    
    //=============================================================================
    public function lengthSquared ():Number {
        return this.dot(this);
    }
    
    //=============================================================================
    public function distance (rhs:Vector3):Number {
        return rhs.subtract(this).length();
    }
    
    //=============================================================================
    public function distanceSquared (rhs:Vector3):Number {
        return rhs.subtract(this).lengthSquared();
    }
    
    //=============================================================================
    public function normalize ():Vector3 {
        if (x == 0 && y == 0)
            throw Error("Divide by zero!");
        
        scale(1 / length());
        return this;
    }
    
    //=============================================================================
    public function normalized ():Vector3 {
        return new Vector3(this).normalize();
    }
    
    //=============================================================================
    public function equals (rhs:Vector3):Boolean {
        const epsilon:Number = .001;
        return (Math.abs(x - rhs.x) < epsilon && Math.abs(y - rhs.y) < epsilon && Math.abs(z - rhs.z) < epsilon);
    }
    
    //=============================================================================
    public function project (rhs:Vector3):Vector3 {
        var projection:Vector3 = rhs.normalized();
        projection.scale(dot(projection));
        return projection;
    }
    
    //=============================================================================
    public function projectPerp (rhs:Vector3):Vector3 {
        return subtract(project(rhs));
    }
    
    //=============================================================================
    public function projectPoint ():Point {
        return new Point(x, y);
    }
    
    //=============================================================================
    public function lerp (rhs:Vector3, t:Number):Vector3 {
        return rhs.subtract(this).scale(t);
    }
    
    //=============================================================================
    public function zero ():Vector3 {
        x = 0;
        y = 0;
        z = 0;
        return this;
    }
    
    //=============================================================================
    public function clone ():Vector3 {
        return new Vector3(x, y, z);
    }
}

}
