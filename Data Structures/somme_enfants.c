#include <stdio.h>
#include <stdlib.h>

int CalculSommeEnfants(Arbre a)
{
	if(a->gauche==NULL && a->droite==NULL)
		return 0;
	else return CalculSommeEnfants(a->gauche) + CalculSommeEnfants(a->droite) + a->gauche->valeur + a->droite->valeur;
}


int SommeEnfants(Arbre a)
{
	if(a->droite==NULL && a->gauche==NULL )
		return 1;
	else return a->valeur==CalculSommeEnfants(a) && SommeEnfants(a->gauche) && SommeEnfants(a->droite);
}