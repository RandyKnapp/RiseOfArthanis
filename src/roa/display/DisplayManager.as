// CharBlockData.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display 
{
import flash.net.registerClassAlias;
import roa.display.data.AnimatedCharBlockData;
import roa.display.data.AnimatedCharBlockFrameData;
import roa.display.data.CharBlockData;
import roa.display.data.CharBlockDataBase;
import roa.display.data.CharBlockInstanceData;
import roa.display.data.CharInfoData;

// DisplayManager
///////////////////////////////////////////////////////////////////////////////////////////////////
public class DisplayManager 
{
    // Data
    private static var blocks:Object = new Object();
    
    //=============================================================================================
    public static function init ():void
    {
        registerClassAlias("CharInfoData", CharInfoData);
        registerClassAlias("CharBlockData", CharBlockData);
        registerClassAlias("CharBlockInstanceData", CharBlockInstanceData);
        registerClassAlias("AnimatedCharBlockData", AnimatedCharBlockData);
        registerClassAlias("AnimatedCharBlockData", AnimatedCharBlockFrameData);
    }
    
    //=============================================================================================
    public static function addBlock (block:CharBlockDataBase):void
    {
        if (blocks[block.id] != undefined)
            delete blocks[block.id];
            
        blocks[block.id] = block;
    }
    
    //=============================================================================================
    public static function getBlockInstanceData (id:String, x:int = 0, y:int = 0, z:int = 0):CharBlockInstanceData
    {
        if (blocks[id] == undefined)
            return null;
        
        var instance:CharBlockInstanceData = new CharBlockInstanceData();
        instance.data = blocks[id];
        instance.id = id;
        instance.x = x;
        instance.y = y;
        instance.z = z;
        
        return instance;
    }
}

}