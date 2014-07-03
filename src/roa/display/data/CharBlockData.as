// CharInfo.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data 
{
import flash.display.Sprite;
import roa.display.char.CharInfo;

// CharBlockData
///////////////////////////////////////////////////////////////////////////////////////////////////
public class CharBlockData extends Sprite
{
    // Data
    public var chars:Object = new Object();

    //=============================================================================================
    public function setChar (x:int, y:int, data:CharInfoData):void
    {
        if (chars[x] == undefined)
            chars[x] = new Object();
            
        // Remove current object if it exists
        if (chars[x][y] != undefined)
            removeChild(chars[x][y]);
        
        // Make a new one and add it
        var charInfo:CharInfo = new CharInfo(data);
        charInfo.mouseEnabled = false;
        charInfo.x = x * CharInfo.WIDTH;
        charInfo.y = y * CharInfo.HEIGHT;
        chars[x][y] = charInfo;
        addChild(charInfo);
    }
    
    //=============================================================================================
    public function getChar (x:int, y:int):CharInfoData
    {
        if (chars[x] == undefined)
            return null;
            
        if (chars[x][y] == undefined)
            return null;
            
        return (chars[x][y] as CharInfo).data.clone();
    }
    
    //=============================================================================================
    public function eraseChar (x:int, y:int):void
    {
        if (chars[x] == undefined)
            return;
            
        if (chars[x][y] == undefined)
            return;
            
        removeChild(chars[x][y]);
        delete chars[x][y];
    }
}

}