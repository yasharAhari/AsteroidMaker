import peasy.*;

PeasyCam camera;
AsteroidGenerator g;
Asteroid a ;



void setup(){
 size(1000,500,P3D);
camera = new PeasyCam(this, 0, 0, 0, 50);
 //test 1;
  g = new AsteroidGenerator(1000,10);
  a = new Asteroid(g);
 a.generate();
 
}





void draw()
{
   background(255);
 a.drawVertexes();
  
  
}
