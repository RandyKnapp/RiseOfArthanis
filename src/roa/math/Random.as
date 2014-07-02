package roa.math {

/****************************************************************************
 *
 *    Random.as
 *    Random implementation
 *
 *    By Randy Knapp (12/7/2012)
 *    Owned by Randy Knapp
 *
 ***/

import flash.geom.Point;
import flash.utils.Dictionary;

/****************************************************************************
 *
 *    Random
 *
 ***/

public class Random {
    
    // Data
    private static var s_globalRandoms:Dictionary = new Dictionary();
    private var m_seed:uint = 0;
    private var m_state:uint = 0;
    
    //=============================================================================
    public static function global (key:* = null, seed:uint = 1):Random {
        var rand:Random = s_globalRandoms[key];
        if (rand == null) {
            rand = new Random(seed);
            s_globalRandoms[key] = rand;
        }
        return rand;
    }
    
    //=============================================================================
    public function Random (seed:uint = 1) {
        this.m_seed = Math.max(1, seed);
        this.m_state = this.m_seed;
    }
    
    // Implementation of the Park Miller (1988) "minimal standard" linear congruential
    // pseudo-random number generator by Michael Baczynski, www.polygonal.de, (seed * 16807) % 2147483647
    //=============================================================================
    private function advanceState ():uint {
        return (m_state = (m_state * 16807) % 2147483647);
    }
    
    // Resets the current state to the originally-supplied seed value.
    //=============================================================================
    public function resetSequence ():void {
        m_state = m_seed;
    }
    
    // [0,1)
    //=============================================================================
    public function number ():Number {
        return advanceState() / 0x7FFFFFFF + 0.000000000233;
    }
    
    // [min,max)
    //=============================================================================
    public function numberInRange (min:Number, max:Number):Number {
        return min + number() * (max - min);
    }
    
    // [min,max)
    //=============================================================================
    public function intInRange (min:int, max:int):int {
        return Math.floor(numberInRange(min - 0.5, max + 0.5) + 0.5);
    }
    
    // [min,max)
    //=============================================================================
    public function pointInRange (minX:Number, maxX:Number, minY:Number, maxY:Number):Point {
        return new Point(numberInRange(minX, maxX), numberInRange(minY, maxY));
    }
    
    // true or false
    //=============================================================================
    public function boolean (chanceOfTrue:Number = 0.5):Boolean {
        return number() < chanceOfTrue;
    }
    
    // -1 or +1
    //=============================================================================
    public function sign (chanceOfPositive:Number = 0.5):Number {
        return boolean(chanceOfPositive) ? +1.0 : -1.0;
    }
}
}
