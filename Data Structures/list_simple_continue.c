#include <stdio.h>
#include <stdlib.h>

typedef int Element;

typedef struct cellule* Place;

typedef struct cellule{
Element valeur;
struct cellule *suivant;
}Cellule;

typedef struct Liste{
Cellule *premier;
}Liste;

Liste liste_vide()
{
	Liste l;
	l.premier=NULL;
	return l;
}
int longueur(Liste l)
{
	int n=0;
	while(l.premier!=NULL)
	{
		l.premier=l.premier->suivant;
		n++;
	}
	return n;
};
Liste inserer(Liste l, Element e)
{
	Cellule *c=(Cellule *)malloc(sizeof(Cellule));
	c->valeur=e;
	c->suivant=l.premier;
	l.premier=c;
	
	return l;
	
}
Liste insererP(Liste l,int i, Element e)
{
	if(i<0 && i>longueur(l))
	{
		printf("err ");
		exit(-1);
	}
	
	Cellule *c=(Cellule *)malloc(sizeof(Cellule));
	c->valeur=e;
	c->suivant=NULL;
	if(i==0)
	{
		c->suivant=l.premier;
		l.premier=c;	
	}else
	{
		Liste tmp=l;
		int j=0;
		for(j=0;j<i-1;j++)
		{
			tmp.premier=tmp.premier->suivant;
		}
		c->suivant=tmp.premier->suivant;
		tmp.premier->suivant=c;
		return l;
	}
}

Liste supprimer(Liste l, int i)
{
	if(i<0 && i>longueur(l))
	{
		printf("err ");
		exit(-1);
	}else
	{
		if(i==0)
		{
			l.premier=l.premier->suivant;
		}
		else
		{
			Liste tmp=l;
			int j=0;
		     for(j=0;j<i-1;j++)
		     { 
			   tmp.premier=tmp.premier->suivant;
		     }
	         tmp.premier->suivant=tmp.premier->suivant->suivant;
		     return l;
		}
	}
	
}
Element keme (Liste l, int k)
{
	if(k<0 || k>longueur(l))
	{
		printf("err:");
		exit(-1);
	}else
	{
		Liste tmp=l;
		int j=0;
		for(j=0;j<k;j++)
		{
			tmp.premier=tmp.premier->suivant;
	    }
		return tmp.premier->valeur; 
	}
}
Place acces(Liste l, int i)
{
	if(i<0 || i>longueur(l))
	{
		printf("err");
		exit(0);
	}
	if(i==0)
	{
		return l.premier;
	}
	else
	{
	    Liste tmp=l;
	    int j=0;
		for(j=0;j<i;j++)
		{
			tmp.premier=tmp.premier->suivant;
		}
		return tmp.premier;
	}
}
Element contenu(Liste l, Place i)
{
	return i->valeur;
}

Place succ (Liste l, Place i)
{
	if(l.premier->suivant==NULL)
	{
		printf("err ");
		exit(-1);
	}
	return l.premier->suivant;
}

int main(int argc, char *argv[]) {
	return 0;
}
