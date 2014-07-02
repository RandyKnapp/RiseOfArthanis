package roa.math {

/****************************************************************************
 *
 *    Matrix3x3.as
 *    Mathematical 3x3 matrix of numbers
 *
 *    By Randy Knapp (12/7/2012)
 *    Owned by Randy Knapp
 *
 ***/

/****************************************************************************
 *
 *    Matrix3x3
 *
 ***/

public class Matrix3x3 {
    
    // Constants
    private static const COUNT:int = 9;
    private static const WIDTH:int = 3;
    private static const HEIGHT:int = 3;
    
    // Public data
    public var data:Array = new Array(COUNT);
    
    //=============================================================================
    public function Matrix3x3 (... args) {
        if (args[0] is Matrix3x3) {
            var rhs:Matrix3x3 = args[0] as Matrix3x3;
            for (var i:int = 0; i < COUNT; ++i) {
                data[i] = rhs.data[i];
            }
        }
        else {
            zero();
        }
    }
    
    //=============================================================================
    public function toString ():String {
        var outStrings:Array = new Array(3);
        outStrings[0] = new Array(3);
        outStrings[1] = new Array(3);
        outStrings[2] = new Array(3);
        
        for (var row:int = 0; row < HEIGHT; ++row) {
            for (var col:int = 0; col < WIDTH; ++col) {
                outStrings[col][row] = getElement(col, row).toString();
            }
        }
        
        // Build the output
        var maxWidths:Array = new Array(3);
        for (var i:int = 0; i < 3; ++i) {
            maxWidths[i] = Math.max(outStrings[i][0].length, outStrings[i][1].length, outStrings[i][2].length);
        }
        
        var out:String = new String();
        for (row = 0; row < HEIGHT; ++row) {
            out += "[ ";
            for (col = 0; col < WIDTH; ++col) {
                var w:int = maxWidths[col];
                var s:String = outStrings[col][row] as String;
                var numSpaces:int = w - s.length;
                for (i = 0; i < numSpaces; ++i) {
                    s = " " + s;
                }
                out += s + " ";
            }
            out += "]";
            if (row != HEIGHT - 1)
                out += "\n";
        }
        
        return out;
    }
    
    //=============================================================================
    public function getElement (col:int, row:int):Number {
        return data[row * WIDTH + col];
    }
    
    //=============================================================================
    public function setElement (col:int, row:int, x:Number):void {
        data[row * WIDTH + col] = x;
    }
    
    //=============================================================================
    public function zero ():Matrix3x3 {
        for (var i:int = 0; i < COUNT; ++i) {
            data[i] = 0;
        }
        
        return this;
    }
    
    //=============================================================================
    public function identity ():Matrix3x3 {
        zero();
        setElement(0, 0, 1);
        setElement(1, 1, 1);
        setElement(2, 2, 1);
        
        return this;
    }
    
    //=============================================================================
    public function getRow (row:int):Vector3 {
        return new Vector3(getElement(0, row), getElement(1, row), getElement(2, row));
    }
    
    //=============================================================================
    public function getColumn (col:int):Vector3 {
        return new Vector3(getElement(col, 0), getElement(col, 1), getElement(col, 2));
    }
    
    //=============================================================================
    public function setColumn (col:int, v:Vector3):void {
        setElement(col, 0, v.x);
        setElement(col, 1, v.y);
        setElement(col, 2, v.z);
    }
    
    //=============================================================================
    public function setRow (row:int, v:Vector3):void {
        setElement(0, row, v.x);
        setElement(1, row, v.y);
        setElement(2, row, v.z);
    }
    
    //=============================================================================
    public function transpose ():Matrix3x3 {
        var temp:Matrix3x3 = new Matrix3x3(this);
        data[1] = temp.data[3];
        data[2] = temp.data[6];
        data[3] = temp.data[1];
        data[5] = temp.data[7];
        data[6] = temp.data[2];
        data[7] = temp.data[5];
        return this;
    }
    
    //=============================================================================
    public function scale (a:Number):Matrix3x3 {
        for (var i:int = 0; i < COUNT; ++i) {
            data[i] *= a;
        }
        
        return this;
    }
    
    //=============================================================================
    public function concat (rhs:Matrix3x3):Matrix3x3 {
        var ret:Matrix3x3 = new Matrix3x3();
        
        for (var i:int = 0; i < 3; ++i) {
            var col:Vector3 = rhs.getColumn(i);
            ret.setColumn(i, new Vector3(col.dot(getRow(0)), col.dot(getRow(1)), col.dot(getRow(2))));
        }
        
        return ret;
    }
    
    //=============================================================================
    public function multiply (rhs:Vector3):Vector3 {
        return new Vector3(rhs.dot(getRow(0)), rhs.dot(getRow(1)), rhs.dot(getRow(2)));
    }
    
    //=============================================================================
    public function scaling (sx:Number, sy:Number):Matrix3x3 {
        identity();
        setElement(0, 0, sx);
        setElement(1, 1, sy);
        return this;
    }
    
    //=============================================================================
    public function translation (x:Number, y:Number):Matrix3x3 {
        identity();
        setElement(2, 0, x);
        setElement(2, 1, y);
        return this;
    }
    
    //=============================================================================
    public function rotationRad (angle:Number):Matrix3x3 {
        identity();
        setElement(0, 0, Math.cos(angle));
        setElement(1, 1, Math.cos(angle));
        setElement(0, 1, Math.sin(angle));
        setElement(1, 0, -Math.sin(angle));
        return this;
    }
    
    //=============================================================================
    public function rotationDeg (angle:Number):Matrix3x3 {
        return rotationRad((angle / 180) * Math.PI);
    }
}

}

