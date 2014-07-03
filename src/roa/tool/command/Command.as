// Command.as
// Randy Knapp
// 07/02/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.command 
{
// Command
//////////////////////////////////////////////////////////////////////////////////////////////////
public class Command 
{
    // Types
    public static const DRAW_CHARS:String  = "DRAW_CHARS";
    public static const ERASE_CHARS:String = "ERASE_CHARS";
    
    // Constants
    public static const ACTION_UNDO:String = "undo";
    public static const ACTION_REDO:String = "redo";
    
    // Data
    private var m_target:*;
    private var m_type:String;
    private var m_undoData:*;
    private var m_redoData:*;
    
    // Properties
    public function get target ():* { return m_target; }
    public function set target (value:*):void { m_target = value; }
    public function get type ():String { return m_type; }
    public function set type (value:String):void { m_type = value; }
    public function get undoData ():* { return m_undoData; }
    public function set undoData (value:*):void { m_undoData = value; }
    public function get redoData ():* { return m_redoData; }
    public function set redoData (value:*):void { m_redoData = value; }
    
    //============================================================================================
    public function Command (target:*, type:String, undoData:*, redoData:*) 
    {
        m_target = target;
        m_type = type;
        m_undoData = undoData;
        m_redoData = redoData;
    }

}

}