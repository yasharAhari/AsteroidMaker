/**
  The class Vertex is same as Vector3 in Unity, hold the coordinate in 3D.



*/
class Vertex
{
 private float _x;
 private float _y;
 private float _z;
 private float _radius;
 
 public Vertex(float x,float y,float z,float radius)
 {
  _x = x;
  _y = y;
  _z = z;
  _radius = radius;
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
  
  public float getRadius()
  {
   return _radius; 
  }
  
}

/**
  The asteroid Generator is a class that randomly generates data for asteroids.


*/
class AsteroidGenerator
{
  private float size;
  private ArrayList<Vertex> _vertexes;
  private float noiseLevel;
  private int variety_points; 
  private float detail_level = 5;
  private AsteroidGenerator(float size , float noiseLevel,int variety_points,float detail_level)
  {
    this.size = size;
    this.noiseLevel = noiseLevel;
    this.variety_points = variety_points;
    this.detail_level = detail_level; 
    //_vertexes = new ArrayList<Vertex>();
    
  }
  
  private AsteroidGenerator(float noiseLevel,int variety_points,float detail_level)
  {
    this.size = random(50,1500);
    this.noiseLevel = noiseLevel;
    this.variety_points = variety_points;
    this.detail_level = detail_level; 
    //_vertexes = new ArrayList<Vertex>();
  }
  
  
  private Vertex getCoordinates(float theta, float phi, float radius)
  {
    theta = theta * PI/180;
    phi = phi * PI/180;
   float x = radius * sin(theta) * cos(phi);
   float y = radius * sin(theta) * sin(phi);
   float z = radius * cos(theta);
   Vertex v = new Vertex(x,y,z,radius);
   return v;
    
    
  }
  
  public void generate()
  {
    // first clear off the old vertexes... 
     _vertexes = new ArrayList<Vertex>();
    
    
    
    // first, create and populate the variety array
    
    float[] variety = new float[variety_points];
    for(int index = 0 ; index < variety_points; ++index)
    {
      variety[index] = random(-2,2);
      
    }
    
    // create the initial radius
    float radius = random(3*size/4,size);
    float initial_radius = radius;
    
    // North polar radius is the radius that the theta swipe starts, we need to keep that so the other theta swipes start from that radius too.
    float nort_polar_radius = radius;
    // The south polar radius should be same but it is the radius that theta swipe ends. It will determined after first theta run.
    float south_polar_radius = 0;
    
    boolean first_run_flag_theta = true;
    boolean first_run_flag_phi = true;
    float radius_side_theta = 0;
    float radius_side_phi = 0;
    int theta_vertex_total_count = 0;
    int total_vertex_inserted = 0;
    
    for(float phi = 0 ; phi <= 360; phi = phi + detail_level)
    {
      int theta_vertex_count = 0;
     for(float theta = 0 ; theta <= 180 ; theta = theta + detail_level)
     {
       
       
       // the control block that controls the build 
       if(!first_run_flag_theta)
       {
         
         Vertex side_vertex_theta = _vertexes.get(_vertexes.size() - 1);
         radius_side_theta = side_vertex_theta.getRadius();
          
          
         if(!first_run_flag_phi)
         {
           
           Vertex side_vertex_phi = _vertexes.get(total_vertex_inserted - theta_vertex_total_count);
           radius_side_phi = side_vertex_phi.getRadius(); 
         }
         else
         {
           radius_side_phi = initial_radius;
         }
         
         //float median_radius = (radius_side_theta + radius_side_phi) / 2;
         
         float median_radius = radius_side_phi;
         
         if(theta > 100 && !first_run_flag_phi)
         {
          median_radius = (median_radius + south_polar_radius)/2; 
         }
         
         if(phi > 5)
         {
           //////
           Vertex v = _vertexes.get(theta_vertex_count);
           median_radius = (median_radius + v.getRadius() )/2;
         }
         
         if( theta_vertex_count == 0)
         {
           radius = nort_polar_radius; 
         }
         else
         {
           if(!first_run_flag_phi)
           {
             
             if(theta_vertex_count >= theta_vertex_total_count - 2)
             {
               radius = south_polar_radius;
             }
             
             radius = random(median_radius - noiseLevel, median_radius + noiseLevel);
             
             //radius = radius_side_phi;
           }
           else
           {
             int current_variety_index = (int) map(theta,0,180,0,variety_points-1);
             radius = radius +( variety[current_variety_index] * random(noiseLevel));
           }
         }
       }
       
       
       
       
       //--------------------building the point clusters
       Vertex v = getCoordinates(theta,phi,radius);
       _vertexes.add(v);
       ++theta_vertex_count;
       ++total_vertex_inserted;
       //-------------------------------------------
       
       
       
       
       first_run_flag_theta = false;
      }
      
      if (first_run_flag_phi)
      {
        // this means that the first theta swipe completed, it is the time to determine the south polar radius. 
        south_polar_radius = radius;
        first_run_flag_phi = false;
        theta_vertex_total_count = theta_vertex_count;
        println(theta_vertex_count);
      }
    }
    
    
    
  }
  
  
  public ArrayList<Vertex> getVertexes()
  {
   return this._vertexes; 
    
  }
  
  
}

class Asteroid
{
  private ArrayList<Vertex> _vertexList;
  private ArrayList<Vertex> _UVList;
  private int[] triangels;
  
  private AsteroidGenerator _generator;
  public Asteroid(AsteroidGenerator generator)
  {
    _generator = generator; 
    _vertexList = new ArrayList<Vertex>();
    _UVList = new ArrayList<Vertex>();
    
  }
  
  public void generate()
  {
    _vertexList = new ArrayList<Vertex>();
    _generator.generate();
    _vertexList = _generator.getVertexes();
      
  }
  
  public void addVertex(Vertex _v)
  {
   _vertexList.add(_v); 
    
  }
  
  public void drawVertexes()
  {
    beginShape(POINTS);
    Vertex oldVertex = null;
   for(Vertex vertex : _vertexList)
   {
     vertex(vertex.getX(),vertex.getY(),vertex.getZ());
     
     if(oldVertex != null)
     {
      line(oldVertex.getX(),oldVertex.getY(),oldVertex.getZ(),vertex.getX(),vertex.getY(),vertex.getZ()); 
       
     }
     oldVertex = vertex;
     
   }
   endShape();
  }
  
  
  
  
}
