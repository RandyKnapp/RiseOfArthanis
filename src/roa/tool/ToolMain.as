// ToolMain.as
// Randy Knapp
// 06/29/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool 
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.KeyboardEvent;
import roa.game.ui.CardDisplay;
import roa.game.ui.HandDisplay;
import roa.tool.ui.BlockViewer;
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
    private var m_blockEditor:BlockViewer;

    //============================================================================================
    public function ToolMain () 
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        
        m_starling = new Starling(ToolGame, stage);
        m_starling.start();
        
        /*var rightColumn:uint = 1280 - 84;
        
        m_infoPanel = new InfoPanel();
        m_infoPanel.x = rightColumn;
        m_infoPanel.y = 200;
        
        m_charInfoControls = new CharInfoControls();
        m_charInfoControls.x = rightColumn;
        m_charInfoControls.y = 20;
        
        m_blockEditor = new BlockViewer(960, 540, m_charInfoControls);
        m_blockEditor.x = 215;
        m_blockEditor.y = 20;
        
        // Order matters
        addChild(m_blockEditor);
        addChild(m_infoPanel);
        addChild(m_charInfoControls);
        
        // Test Buttons
        var undo:Button = new Button();
        undo.setSize(50, 20);
        undo.label = "Undo";
        undo.x = undo.y = 20;
        addChild(undo);
        
        var redo:Button = new Button();
        redo.setSize(50, 20);
        redo.label = "Redo";
        redo.x = 75;
        redo.y = 20;
        addChild(redo);

        // Setup events
        undo.addEventListener(ButtonEvent.CLICK, function (e:ButtonEvent):void {
            CommandManager.undo();
        });
        redo.addEventListener(ButtonEvent.CLICK, function (e:ButtonEvent):void {
            CommandManager.redo();
        });
        
        // Setup Signals
        m_blockEditor.onHoverChanged.add(m_infoPanel.setInfo);*/
        
        // Game test
        var hand:HandDisplay = new HandDisplay();
        hand.x = stage.stageWidth / 2;
        hand.y = stage.stageHeight - 50;
        addChild(hand);
        
        stage.addEventListener(KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent):void {
            hand.addCard(new CardDisplay());
        })
    }

}

}