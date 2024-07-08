#include <stdio.h>
#include <stdint.h>

#define WIDTH 4
#define HEIGHT 3

extern void flipHorizontal(uint8_t img2[HEIGHT][WIDTH][3], uint8_t img1[HEIGHT][WIDTH][3], int m, int n);

// void flipHorizontal(uint8_t img2[][WIDTH][3], const uint8_t img1[][WIDTH][3], int m, int n) {
//     for (int i = 0; i < n; i++) {
//         for (int j = 0; j < m; j++) {
//             img2[i][m-j-1][0] = img1[i][j][0]; 
//             img2[i][m-j-1][1] = img1[i][j][1];  
//             img2[i][m-j-1][2] = img1[i][j][2];  
//         }
//     }
// }

void printImage(uint8_t img[HEIGHT][WIDTH][3]) {
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            printf("(%d,%d,%d) ", img[i][j][0], img[i][j][1], img[i][j][2]);
        }
        printf("\n");
    }
}

int main() {
    // Source image (hard-coded for simplicity)
    uint8_t img1[HEIGHT][WIDTH][3] = {
        { {1, 2, 3}, {4, 5, 6}, {7, 8, 9}, {10, 11, 12} },
        { {13, 14, 15}, {16, 17, 18}, {19, 20, 21}, {22, 23, 24} },
        { {1, 2, 3}, {4, 5, 6}, {7, 8, 9}, {10, 11, 12} }
    };

    // Destination image
    uint8_t img2[HEIGHT][WIDTH][3] = {0};

    printf("Original Image:\n");
    printImage(img1);

    // Call the assembly function
    flipHorizontal(img2, img1, WIDTH, HEIGHT);

    printf("\nFlipped Image:\n");
    printImage(img2);

    return 0;
}
