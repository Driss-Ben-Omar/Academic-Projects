#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void saisie(int *a,int *b,int *c){
 	printf("\nenter first number");
 	scanf("%d",&a);
 	printf("\nenter second number");
 	scanf("%d",&b);
 	printf("\nenter third number");
 	scanf("%d",&c);
 	printf("%d * x^2 + %d * x + c",a,b,c);
 }
void calcul(int a,int b,int c)
{
	float delta;
	float firstSolution,secondSolution;
	delta=pow(b,2)-4*a*c;
	printf("\n%f",delta);
	if(delta<0){
		printf("\nnot exist a solution");
	}else if(delta==0){
		firstSolution=-b/(2*a);
		printf("\nexist a solution is %f ",firstSolution);
	}else{
		firstSolution=(-b-sqrt(delta))/(2*a);
		firstSolution= (-b+sqrt(delta))/(2*a);
		printf("\nexist two solution is %f and %f ",firstSolution,secondSolution);
	}
}
int main(int argc, char *argv[]) {
	int a,b,c;
	printf("%f",sqrt(25));
	saisie(&a,&b,&c);
	calcul(7,8,3);
	return 0;
}
