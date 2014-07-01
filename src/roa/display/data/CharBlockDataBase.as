// CharBlock.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data 
{
    import flash.display.Sprite;
    import roa.display.char.CharBlock;

// CharBlockDataBase
///////////////////////////////////////////////////////////////////////////////////////////////////
public interface CharBlockDataBase 
{
    function get id ():String;
    function get animated ():Boolean;
    function render (charBlock:CharBlock, frame:int):void;
    function onEnterFrame (frame:int):Boolean;
    function nextFrame (frame:int):int;
}

}