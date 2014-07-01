// CharBlockData.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data 
{

// CharBlockInstanceData
///////////////////////////////////////////////////////////////////////////////////////////////////
public class CharBlockInstanceData 
{
    // Data
    public var id:String;
    public var x:int = 0;
    public var y:int = 0;
    public var z:int = 0;
    
    // Transient data
    [Transient]
    public var data:CharBlockDataBase;
}

}