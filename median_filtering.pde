// Perform Median Filtering on an Image

String fname1 = "Test1_img1.png", fname2 = "Test1_img2.jpg", fname3 = "Before3x3.jpg"; // added the 3rd image from the test file for testing 3x3
String loadName = fname3;  //Use this to easily change loaded image
int regionSize = 3;  //Set this to the size of neighborhood to be used
PImage img, currentImg, medianImg;

void setup() 
{
  size(500, 500);
  surface.setResizable(true);
  //Load and display initial image
  img = loadImage(loadName);
  currentImg = img;
  surface.setSize(img.width, img.height);
  //Add code here to call filter function 
  medianImg = median(img);
}

void draw() {
  image(currentImg, 0, 0);
}

// The median filter loops through every pixel in the image and replaces it with the 
// the median of the 3x3 matrix of neighboring pixels.
PImage median(PImage src) {
  
  // Create a blank image of the same size as the image passed into the function
  // and set the color space
  PImage target = createImage(src.width, src.height, RGB);
  
  // Arrays to hold neigboring pixels
  float[] tempR = new float[regionSize*regionSize];
  float[] tempG = new float[regionSize*regionSize];
  float[] tempB = new float[regionSize*regionSize];
  
  // Loop through every pixel in image leaving a border of unproccessed pixels 
  // around the border of the image. This is an implementation of the naive solution
  // to support variable matrix sizes we would need to create for loops that build matrices
  // based on the reigonSize the user passes in.
  
  for (int y = 0; y < img.height - 1; y++)
  {
    for (int x = 0; x < img.width - 1; x++ )
    {
      // Upper left neigbor
      color c = src.get(x-1, y-1);
      tempR[0] = red(c);
      tempG[0] = green(c);
      tempB[0] = blue(c);
    
      // Upper neighbor
      c = src.get(x, y-1);
      tempR[1] = red(c);
      tempG[1] = green(c);
      tempB[1] = blue(c);
      
      // Upper right neighbor
      c = src.get(x+1, y+1);
      tempR[2] = red(c);
      tempG[2] = green(c);
      tempB[2] = blue(c);
      
      // Left neighbor
      c = src.get(x-1,y);
      tempR[3] = red(c);
      tempG[3] = green(c);
      tempB[3] = blue(c);
      
      // Target Pixel
      c = src.get(x,y);
      tempR[4] = red(c);
      tempG[4] = green(c);
      tempB[4] = blue(c);
      
      // Right neighbor
      c = src.get(x+1,y);
      tempR[5] = red(c);
      tempG[5] = green(c);
      tempB[5] = blue(c);
      
      // Lower left neighbor
      c = src.get(x-1,y+1);
      tempR[6] = red(c);
      tempG[6] = green(c);
      tempB[6] = blue(c);
      
      // Lower neighbor
      c = src.get(x,y+1);
      tempR[7] = red(c);
      tempG[7] = green(c);
      tempB[7] = blue(c);
      
      // Lower right neighbor
      c = src.get(x+1,y+1);
      tempR[8] = red(c);
      tempG[8] = green(c);
      tempB[8] = blue(c);
     
      // Store the sorted array of pixels 
      float[] sortedR = sort(tempR);
      float[] sortedG = sort(tempG);
      float[] sortedB = sort(tempB);
      
      // Set the final values to the median values of the sorted array
      float medianR = sortedR[4];
      float medianG = sortedG[4];
      float medianB = sortedB[4];
      
      target.set(x,y, color(medianR, medianG, medianB));
    }
  }
  // return the filtered image
  return target;
}
void keyReleased() {
  // '1' Displays original image; 
  if(key == '1')
  {
    currentImg = img;
    surface.setSize(currentImg.width, currentImg.height);
  }
  
  // '2' Displays filtered image
  if(key == '2')
  {
    currentImg = medianImg;
    surface.setSize(currentImg.width, currentImg.height);
  }
}
      
