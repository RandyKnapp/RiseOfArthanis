// Main.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa 
{
import flash.display.Sprite;
import roa.display.char.CharBlock;
import roa.display.char.CharInfoColor;
import roa.display.data.AnimatedCharBlockData;
import roa.display.data.AnimatedCharBlockFrameData;
import roa.display.data.CharBlockData;
import roa.display.data.CharInfoData;
import roa.display.DisplayManager;

// Arthanis
///////////////////////////////////////////////////////////////////////////////////////////////////
public class Arthanis extends Sprite 
{
    
    //=============================================================================================
    public function Arthanis () 
    {
        DisplayManager.init();
        
        var frameCount:int = 5;
        var delay:int = 30;
        var w:uint = 159;
        var h:uint = 59;
        var count:uint = w * h;
        var frames:Array = new Array();
        
        var animBlock:AnimatedCharBlockData = new AnimatedCharBlockData();
        animBlock.id = "anim";
        animBlock.looping = false;
        
        for (var blockIndex:int = 0; blockIndex < 5; ++blockIndex)
        {
            var blockData:CharBlockData = new CharBlockData();
            blockData.width = w;
            blockData.height = h;
            
            for (var i:int = 0; i < count; ++i)
            {
                var fi:int = Math.random() * CharInfoColor.list.length;
                var bi:int = Math.random() * CharInfoColor.list.length;
                var f:uint = CharInfoColor.list[fi];
                var b:uint = CharInfoColor.list[bi];
                var charInfo:CharInfoData = new CharInfoData(Math.random() * count, f, b);
                
                blockData.chars.push(charInfo);
            }
            
            animBlock.frames[delay * blockIndex] = new AnimatedCharBlockFrameData(blockData, delay);
        }
        
        DisplayManager.addBlock(animBlock);
        
        var test:CharBlock = new CharBlock("anim");
        //test.x = test.y = 100;
        test.scaleX = test.scaleY = 1;
        addChild(test);
    }
    
}

}