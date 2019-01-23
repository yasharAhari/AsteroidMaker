class Vertex
{
 private float _x;
 private float _y;
 private float _z;
 
 public Vertex(float x,float y,float z)
 {
  _x = x;
  _y = y;
  _z = z;
 }
  
  public float getX()
  {
   return this._x;
   
  }
  public float getY()
  {
   return this._y; 
  }
  
  public float getZ()
  {
   return this._z; 
  }
  
}

class AstroidGenerator
{
  
  
}

class Astroid
{
  private ArrayList<Vertex> _vertexList;
  private ArrayList<Vertex> _UVList;
  private int[] triangels;
  
  private AstroidGenerator _generator;
  public Astroid(AstroidGenerator generator)
  {
    _generator = generator; 
    
  }
  
  
  
  
}
