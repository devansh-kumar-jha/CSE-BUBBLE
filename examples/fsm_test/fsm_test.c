#include<stdio.h>

int main()
{
    // Enter the Input numbers
    int num1=10,num2=-6,num3=13;
    
    // Loop and print the output
    int num4=num2+num3;
    while(num4<num1) {
        printf("%d\n",num4);
        num4++;
    }

    // Exit the program
    return 0;
}
