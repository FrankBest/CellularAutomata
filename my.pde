int colorvalue = (int)random(0,2);
int m = 50;//width
int n = 50;//height
int p[][]  = new int[m][n];
int copy[][] = new int[m][n];
float RATE = 30;

void copyArray(int[][] a, int[][] b, int xLen, int yLen)
{
  for(int i = 0; i < xLen; i++) {
    for(int j = 0; j < yLen; j++) {
      b[i][j] = a[i][j];
    }
  }
}

int getValueAt(int[][] a, int xCoord, int yCoord, int xLen, int yLen)
{
  int xReal = xCoord;
  if (xReal < 0) xReal = xLen -1;
  else if (xReal >= xLen) xReal = 0;

  int yReal = yCoord;
  if (yReal < 0) yReal = yLen -1;
  else if (yReal >= yLen) yReal = 0;

  return a[xReal][yReal];
}


int getMy8SiblingsSum(int[][] a, int xCoord, int yCoord, int xLen, int yLen)
{
  int retVal = 0;
  // your logic here to find the 8 siblings
  retVal += getValueAt(a, xCoord -1, yCoord -1, m, n);
  retVal += getValueAt(a, xCoord -1, yCoord, m, n);
  retVal += getValueAt(a, xCoord -1, yCoord + 1, m, n);
  retVal += getValueAt(a, xCoord, yCoord - 1, m, n);
  retVal += getValueAt(a, xCoord, yCoord + 1, m, n);
  retVal += getValueAt(a, xCoord +1, yCoord -1, m, n);
  retVal += getValueAt(a, xCoord +1, yCoord, m, n);
  retVal += getValueAt(a, xCoord +1, yCoord + 1, m, n);

  return retVal;
}

void SWITCH(float a)
{
  float RECTX = (RATE-5)*width/45;
  if( mousePressed && mouseX >= 20 && mouseX <= width-20 && mouseY >= height-20 && mouseY <= height){
    RATE = 45*a/width+5;
    RECTX = a;
  }
  fill(255);
  rect(RECTX-20,n*10+1,40,18);
}

void CLEAR(){
  for (int i = 0; i < m; i++)
    {
      for(int j = 0; j < n; j++) {
        p[i][j] = 0;
      }
    }
}

void CREATE1()
{
  if (mousePressed == true && mouseX < width && mouseX >= 0 && mouseY < height-20 && mouseY >= 0) {
  p[(mouseX-mouseX%10)/10][(mouseY-mouseY%10)/10] = 1;
  }
}

void setup()
{
  size(10 * m,10 * (n+2));
  background(255);
  frameRate(RATE);
  for (int i = 0; i < m; i++)
  {
    for(int j = 0; j < n; j++) {
      fill(255 - colorvalue * 255);
      rect(10 * i,10 * j, 10, 10);
      p[i][j] = colorvalue;
      colorvalue = (int)random(0,2);
    }
  }
}


void draw()
{
  copyArray(p, copy, m, n);
  int sibsum;
  boolean RUN = true;
  if (mousePressed || (keyPressed && key == 'p')) RUN = ! RUN;
  frameRate(100);
  if (RUN == true){
    frameRate(RATE);
    for(int i = 0; i < m; i++)
    {
      for(int j = 0; j < n; j++) {
         sibsum = getMy8SiblingsSum(copy, i, j, m, n);
         if (sibsum > 3 || sibsum < 2) p[i][j] = 0;
         else if (sibsum == 3) p[i][j] = 1;
      }
    }  
  }
  CREATE1();
  fill(127);
  rect(0,height-20,width,20);
  SWITCH(mouseX);
  if (keyPressed && key == 'c') CLEAR();
  for(int i = 0; i < m; i++)
  {
    for(int j = 0; j < n; j++) {
      fill(255 - p[i][j] * 255);
      rect(10 * i, 10 * j, 10, 10);
    }
  }  
    fill(0);
    text(frameRate,0,20);
}



