// CharInfo.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data
{

// CharInfoData
///////////////////////////////////////////////////////////////////////////////////////////////////
public class CharInfoData 
{
    public var char:uint = 0;
    public var bg:uint = 0;
    public var fg:uint = 0;
    
    //=============================================================================================
    public function CharInfoData (char:* = null, fg:uint = 0, bg:uint = 0) 
    {
        if (char is CharInfoData)
        {
            var data:CharInfoData = char as CharInfoData;
            this.char = data.char;
            this.bg   = data.bg;
            this.fg   = data.fg;
        }
        else
        {
            this.char = char == null ? 0 : char;
            this.fg   = fg;
            this.bg   = bg;
        }
    }
    
}

}