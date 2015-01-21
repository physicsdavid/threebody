// Three body simulation
int xsize=1024;
int ysize=600;

float x1, x2, x3, y1, y2, y3;
float vx1, vx2, vx3, vy1, vy2, vy3;
float ax1, ax2, ax3, ay1, ay2, ay3;
float deltat = 40;
float m1, m2, m3;
float G = -100;

float dx1, dx2, dx3, dy1, dy2, dy3;
float dx21, dx32, dx31, dy21, dy32, dy31;
float dvx1, dvx2, dvx3, dvy1, dvy2, dvy3;
float dax1, dax2, dax3, day1, day2, day3;
float d21, d32, d31;

float scale = 10;
float vmax = 0.5;

void setup()
{
  // body 1
  m1 = 1;
  x1 = random(xsize)+xsize*scale/2;
  y1 = random(ysize)+ysize*scale/2;
  vx1 = random(-vmax,vmax);
  vy1 = random(-vmax,vmax);
  ax1 = 0;
  ay1 = 0;
  
  // body 2
  m2 = 1;
  x2 = random(xsize)+xsize*scale/2;
  y2 = random(ysize)+ysize*scale/2;
  vx2 = random(-vmax,vmax);
  vy2 = random(-vmax,vmax);
  ax2 = 0;
  ay2 = 0;
  
  // body 3
  m3 = 1;
  x3 = random(xsize)+xsize*scale/2;
  y3 = random(ysize)+ysize*scale/2;
  vx3 = random(-vmax,vmax);
  vy3 = random(-vmax,vmax);
  ax3 = 0;
  ay3 = 0;
  
  size(xsize,ysize);
  blendMode(DIFFERENCE);
}

void draw()
{
  //draw current positions
  triangle(x1/scale, y1/scale, x2/scale, y2/scale, x3/scale, y3/scale);
  
  //Calculate accelerations
  dx21 = x2-x1;
  dx32 = x3-x2;
  dx31 = x3-x1;
  dy21 = y2-y1;
  dy32 = y3-y2;
  dy31 = y3-y1;
  d21 = sqrt(dx21*dx21+dy21*dy21);
  d32 = sqrt(dx32*dx32+dy32*dy32);
  d31 = sqrt(dx31*dx31+dy31*dy31);
  
  ax1 = G*(-m3*dx31/pow(d31,3)-m2*dx21/pow(d21,3));
  ay1 = G*(-m3*dy31/pow(d31,3)-m2*dy21/pow(d21,3));
  ax2 = G*(-m1*dx21/pow(d21,3)-m3*dx32/pow(d32,3));
  ay2 = G*(m1*dy21/pow(d21,3)+m3*dy32/pow(d32,3));
  ax3 = G*(m1*dx31/pow(d31,3)+m2*dx32/pow(d32,3));
  ay3 = G*(m1*dy31/pow(d31,3)+m2*dy32/pow(d32,3));

  //Calculate velocities
  vx1 += ax1*deltat;
  vx2 += ax2*deltat;
  vx3 += ax3*deltat;
  vy1 += ay1*deltat;
  vy2 += ay2*deltat;
  vy3 += ay3*deltat;
  
  //Calculate positions
  x1 = (x1 + vx1*deltat + xsize*scale)%(xsize*scale);
  x2 = (x2 + vx2*deltat + xsize*scale)%(xsize*scale);
  x3 = (x3 + vx3*deltat + xsize*scale)%(xsize*scale);
  y1 = (y1 + vy1*deltat + ysize*scale)%(ysize*scale);
  y2 = (y2 + vy2*deltat + ysize*scale)%(ysize*scale);
  y3 = (y3 + vy3*deltat + ysize*scale)%(ysize*scale);

}  


  
