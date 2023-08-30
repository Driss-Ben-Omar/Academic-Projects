#include <stdio.h>
#include <stdlib.h>

typedef int Element ;

typedef struct Cellule
{
   Element valeur;
   struct Cellule * suivant;
}Cellule;

typedef struct File
{
  struct Cellule * tete;
  struct Cellule * queu;
}File;

File file_vide()
{
	File f;
	f.queu=f.tete=NULL;
	return f;
}

int est_videF(File f)
{
	if(f.tete==NULL || f.queu==NULL)
	{
		return 1;
	}
	else return 0;
}

File file_enfiler(File f,Element e)
{
	Cellule *c=(Cellule*)malloc(sizeof(Cellule));
	c->valeur=e;
	c->suivant=NULL;
	if(est_videF(f)==1)
	{
		f.queu=c;
		f.tete=c;
	}
	else
	{
		c->suivant=f.queu;
		f.queu=c;
	}
	f.queu=c;
	return f;
}

File file_defiler(File f)
{
	if(est_videF(f)==1)
	{
		printf("err : la file est vide");
	}
	else
	{
		f.tete=f.tete->suivant;
		if(f.tete==NULL)
		{
			f.queu=NULL;
		}
	}
	return f;
}
Element file_tete(File f)
{
	if(est_videF(f)==1)
	{
		printf("err : la file est vide");
	}
	else
	{
		return f.tete->valeur;
	}
}
int main(int argc, char *argv[]) {
	return 0;
}
