#include<stdio.h>

char magic[5];     // more than enough space to read in "P3\n" plus null

int rgb_to_gray(int r, int g, int b, int ppm_max);
void iterate_through_pix(int rows, int cols, int ppm_max, int x1, int x2, int y1, int y2);

int main() {
  int rows, cols, x1, x2, y1, y2;
  int ppm_max;

  //fgets(magic, 5, stdin);
  puts("P3");

  scanf("%d%d%d%d", &x1, &x2, &y1, &y2);

  scanf("%d%d", &cols, &rows);
  printf("%d\n%d\n", cols, rows);

  scanf("%d", &ppm_max);
  printf("%d\n", 255);


  
  iterate_through_pix(rows, cols, ppm_max, x1, x2, y1, y2);
 
}


void iterate_through_pix(int rows, int cols, int ppm_max, int x1, int x2, int y1, int y2)
{
    int i, j;
    int r, g, b, gray, normal; 
    
    for(i=0; i<rows; i++) {
      for(j=0; j<cols; j++) {
        if (j >= x1 && j <= x2)
        {
            if (i >= y1 && i <= y2)
            {
                scanf("%d%d%d", &r, &g, &b);
                printf("%d\n", r);
                printf("%d\n", g);
                printf("%d\n", b);
            }
            else
            {
                scanf("%d%d%d", &r, &g, &b);
                gray = rgb_to_gray(r, g, b, ppm_max);
                printf("%d\n", gray);
                printf("%d\n", gray);
                printf("%d\n", gray);
            }
        }
        else
        {
            scanf("%d%d%d", &r, &g, &b);
            gray = rgb_to_gray(r, g, b, ppm_max);
            printf("%d\n", gray);
            printf("%d\n", gray);
            printf("%d\n", gray);
        }
    }
  }
} 


int rgb_to_gray(int r, int g, int b, int ppm_max) {
  return ((r*30 + g*59 + b*11) * 255) / (100 * ppm_max);
  }  // Follow exactly this ordering in assembly