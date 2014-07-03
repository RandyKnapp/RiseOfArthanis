// CommandBuilder.as
// Randy Knapp
// 07/02/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.command 
{
// CommandBuilder
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CommandBuilder 
{
    // Data
    private var m_proxy:*;
    private var m_building:Boolean = false;
    private var m_currentCommandType:String = null;
    private var m_undoData:Array = null;
    private var m_redoData:Array = null;
    
    // Properties
    public function get building ():Boolean { return m_building; }
    
    //============================================================================================
    public function CommandBuilder (proxy:*) 
    {
        m_proxy = proxy;
    }
    
    //=============================================================================================
    public function beginCommand (type:String):void
    {
        if (m_building)
            endCommand();
            
        m_building = true;
        m_currentCommandType = type;
        m_undoData = new Array();
        m_redoData = new Array();
    }
    
    //=============================================================================================
    public function endCommand ():void
    {
        if (!m_building)
            return;
            
        CommandManager.pushCommand(m_proxy, m_currentCommandType, m_undoData, m_redoData);
        m_building = false;
        m_currentCommandType = null;
        m_undoData = null;
        m_redoData = null;
    }
    
    //=============================================================================================
    public function addCommandlet (action:String, type:String, data:*):void
    {
        if (!m_building)
            return;
            
        data.type = type;
        if (action == Command.ACTION_UNDO)
            m_undoData.push(data);
        else
            m_redoData.push(data);
    }

}

}