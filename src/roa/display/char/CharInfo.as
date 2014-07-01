// Arthanis.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.char
{
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import roa.display.data.CharInfoData;

// CharInfo
///////////////////////////////////////////////////////////////////////////////////////////////////
public class CharInfo extends Sprite 
{
    // Constants
    public static const WIDTH:uint = 8;
    public static const HEIGHT:uint = 12;
    private static const SOURCE_WIDTH:uint = 32;
    private static const SOURCE_HEIGHT:uint = 32;
    
    // Data
    private var m_data:CharInfoData;
    
    // Embedded data
    [Embed(source = "characters.png")]
    private static var CharacterImage:Class;
    
    // Display objects
    private static var s_source:Bitmap = new CharacterImage();
    private var m_charDisplay:Shape;
    private var m_background:Shape;
    
    // Properties
    public function get char ():uint { return m_data.char; }
    public function set char (value:uint):void { m_data.char = value; updateChar(); }
    public function get bg ():uint { return m_data.bg; }
    public function set bg (value:uint):void { m_data.bg = value; updateBg(); }
    public function get fg ():uint { return m_data.fg; }
    public function set fg (value:uint):void { m_data.fg = value; updateChar(); }

    //=============================================================================================
    public function CharInfo (data:* = null, fg:uint = 0, bg:uint = 0) 
    {
        if (data != null)
        {
            if (data is CharInfoData)
                m_data = data;
            else if (data is uint)
                m_data = new CharInfoData(data as uint, fg, bg);
        }
        else
            m_data = new CharInfoData();
        
        m_background = new Shape();
        addChild(m_background);
        
        m_charDisplay = new Shape();
        addChild(m_charDisplay);
        
        updateBg();
        updateChar();
    }
    
    //=============================================================================================
    private function updateBg ():void
    {
        // Background
        m_background.graphics.clear();
        
        var color:uint = CharInfoColor.list[bg];
        var a:uint = (color >> 24) & 0x000000FF;
        if (a > 0)
        {
            color = color & 0x00FFFFFF;
            var alpha:Number = a / 255.0;
            m_background.graphics.beginFill(color, alpha);
            m_background.graphics.drawRect(0, 0, WIDTH, HEIGHT);
            m_background.graphics.endFill();
        }
    }
    
    //=============================================================================================
    private function updateChar ():void
    {
        // Character
        var x:uint = char % SOURCE_WIDTH;
        var y:uint = char / SOURCE_HEIGHT;
        var m:Matrix = new Matrix();
        m.translate(-x * WIDTH, -y * HEIGHT);
        m_charDisplay.graphics.clear();
        m_charDisplay.graphics.beginBitmapFill(s_source.bitmapData, m);
        m_charDisplay.graphics.drawRect(0, 0, WIDTH, HEIGHT);
        m_charDisplay.graphics.endFill();
        
        // Color
        var color:uint = CharInfoColor.list[fg];
        var a:Number = ((color >> 24) & 0xFF);
        var r:Number = ((color >> 16) & 0xFF);
        var g:Number = ((color >> 8) & 0xFF);
        var b:Number = ((color) & 0xFF);
        m_charDisplay.transform.colorTransform = new ColorTransform(0, 0, 0, 0, r, g, b, a);
    }
}

}