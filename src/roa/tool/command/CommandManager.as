// CommandManager.as
// Randy Knapp
// 07/02/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.command 
{
import org.osflash.signals.Signal;

// CommandManager
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CommandManager 
{
    // Constants
    private static const COMMAND_LIST_MAX:uint = 4;
    
    // Data
    private static var m_commands:Array = new Array();
    private static var m_redoStack:Array = new Array();
    private static var m_signals:Object = new Object();
    
    //============================================================================================
    public static function addCommandListener (commandType:String, listener:Function):void
    {
        if (m_signals[commandType] == undefined)
            m_signals[commandType] = new Signal();
            
        m_signals[commandType].add(listener);
    }
    
    //============================================================================================
    public static function pushCommand (target:*, commandType:String, undoData:*, redoData:*):void
    {
        // If we're doing an undo/redo set, remove all commands after this one
        if (m_redoStack.length != 0)
            m_redoStack = new Array();
            
        // Pop the front of the stack if we're at the max
        else if (m_commands.length > COMMAND_LIST_MAX)
            m_commands.shift();
        
        m_commands.push(new Command(target, commandType, undoData, redoData));
    }
    
    //============================================================================================
    public static function undo ():void
    {
        if (!canUndo())
            return;
            
        var command:Command = m_commands.pop();
        m_redoStack.push(command);

        if (m_signals[command.type] == undefined)
            return;
            
        var signal:Signal = m_signals[command.type] as Signal;
        signal.dispatch(Command.ACTION_UNDO, command);
    }
    
    //============================================================================================
    public static function redo ():void
    {
        if (!canRedo())
            return;
        
        var command:Command = m_redoStack.pop();
        m_commands.push(command);
        
        if (m_signals[command.type] == undefined)
            return;
            
        var signal:Signal = m_signals[command.type] as Signal;
        signal.dispatch(Command.ACTION_REDO, command);
    }
    
    //============================================================================================
    public static function canUndo ():Boolean
    {
        return m_commands.length > 0;
    }
    
    //============================================================================================
    public static function canRedo ():Boolean
    {
        return m_redoStack.length > 0;
    }

}

}