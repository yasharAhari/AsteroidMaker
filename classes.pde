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
  private float size;
  private ArrayList<Vertex> _vertexes;
  private AstroidGenerator(float size)
  {
    this.size = size;
    _vertexes = new ArrayList<Vertex>();
    
  }
  
  private AstroidGenerator()
  {
    this.size = random(50,1500);
    _vertexes = new ArrayList<Vertex>();
  }
  
  
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
    _vertexList = new ArrayList<Vertex>();
    _UVList = new ArrayList<Vertex>();
    
  }
  
  public void generate()
  {
      
  }
  
  public void addVertex(Vertex _v)
  {
   _vertexList.add(_v); 
    
  }
  
  public void drawVertexes()
  {
   for(Vertex vertex : _vertexList)
   {
    point(vertex.getX(),vertex.getY(),vertex.getZ()); 
     
   }
  }
  
  
  
  
}
