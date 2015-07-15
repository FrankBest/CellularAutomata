int colorvalue = (int)random(0,2);
int m = 50;//width
int n = 50;//height
int p[][]  = new int[m][n];
int copy[][] = new int[m][n];


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

void setup()
{
  size(10 * m,10 * n);
  background(255);
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
  for(int i = 0; i < m; i++)
  {
    for(int j = 0; j < n; j++) {
       sibsum = getMy8SiblingsSum(copy, i, j, m, n);
       if (sibsum > 3 || sibsum < 2) p[i][j] = 0;
       else if (sibsum == 3) p[i][j] = 1;
    }
  }  

  for(int i = 0; i < m; i++)
  {
    for(int j = 0; j < n; j++) {
      fill(255 - p[i][j] * 255);
      rect(10 * i, 10 * j, 10, 10);
    }
  }  
}




