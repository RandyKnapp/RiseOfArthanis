// ToolMain.as
// Randy Knapp
// 06/29/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool 
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import roa.tool.ui.CharColorPicker;
import roa.tool.ui.CharInfoControls;
import roa.tool.ui.InfoPanel;
import starling.core.Starling;
	
// ToolMain
//////////////////////////////////////////////////////////////////////////////////////////////////
public class ToolMain extends Sprite 
{
    // Data
    private var m_starling:Starling;
    
    // Controls
    private var m_charInfoControls:CharInfoControls;
    private var m_infoPanel:InfoPanel;

    //============================================================================================
    public function ToolMain () 
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        
        m_starling = new Starling(ToolGame, stage);
        m_starling.start();
        
        var rightColumn:uint = 1280 - 84;
        
        m_infoPanel = new InfoPanel();
        m_infoPanel.x = rightColumn;
        m_infoPanel.y = 200;
        addChild(m_infoPanel);
        
        m_charInfoControls = new CharInfoControls();
        m_charInfoControls.x = rightColumn;
        m_charInfoControls.y = 20;
        addChild(m_charInfoControls);
    }

}

}