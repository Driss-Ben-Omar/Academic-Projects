#include <stdio.h>
#include <stdlib.h>


typedef int element;

typedef struct cellule
{
	element donnee;
	struct cellule *suivant;
}cellule;  

typedef struct Pile
{
	cellule *tete;
}Pile;

Pile pile_vide()
{
	Pile p;
	p.tete=NULL;
	return p;
}
int est_vide(Pile p)
{
	if(p.tete==NULL)return 0;
	else return 1;
}
Pile empiler(Pile p,element e)
{
	cellule *c=(cellule*)malloc(sizeof(cellule));
	c->donnee=e;
	c->suivant=p.tete;
	p.tete=c;
	return p;
}
Pile depiler(Pile p)
{
	if(!est_vide(p))
	{
		p.tete=p.tete->suivant;
		return p;
	}
	else
	{
		printf("la pile est vide");
		return ;
	}
}
element sommet(Pile p)
{
	if(est_vide(p)==1)
	{
		return p.tete->donnee;
	}
	else
	{
		printf("err: la pile est vide");
		return;
	}
}
 
int main(int argc, char *argv[]) 
{

	return 0;
}
