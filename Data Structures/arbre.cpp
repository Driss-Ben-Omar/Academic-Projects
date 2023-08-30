#include <iostream>
#include <stdio.h>
#include <stdlib.h>
typedef struct arbre
{
	int value;
	struct arbre *left;
	struct arbre *right;
}arbre;

arbre* creerArbre(int value,arbre *leftTree,arbre *rightTree)
{
	arbre *element=(arbre*)malloc(sizeof(arbre));
	element->value=value;
	element->left=leftTree;
	element->right=rightTree;
	return element;
}
void detruit(arbre* tree)
{
	if(tree==NULL)
	{
		return;
	}else
	{
		detruit(tree->left);
		detruit(tree->right);
		free(tree);
	}
}
int numberNode(arbre *tree)
{
	if(tree==NULL) return 0;
	else return 1+numberNode(tree->left)+numberNode(tree->right);
}
void afficheInfexe(arbre* tree)
{
	if(tree==NULL)
	{
		return;
	}
	else
	{
		afficheInfexe(tree->left);
		printf("%d\t",tree->value);
		afficheInfexe(tree->right);
	}
}
void affichePrefixe(arbre* tree)
{
	if(tree==NULL)
	{
			 return;
	}
	else
	{
		printf("%d\t",tree->value);
		affichePrefixe(tree->left);
		affichePrefixe(tree->right);
	}
}
void affichePostefixe(arbre* tree)
{
	if(tree==NULL) return;
	else
	{
		affichePostefixe(tree->left);
		affichePostefixe(tree->right);
		printf("%d\t",tree->value);
	}
}
arbre* ajouterABR(arbre *tree,int value)
{
	if(tree==NULL) return creerArbre(value,NULL,NULL);
	else if(tree->value<value) return ajouterABR(tree->right,value);
	else return ajouterABR(tree->left,value);
}
arbre* trouve(arbre* tree,int value)
{
	if(tree==NULL) return NULL;
	else if(tree->value==value) return tree;
	else if(tree->value<value) return trouve(tree->right,value);
	else return trouve(tree->right,value);
}
int main(int argc, char** argv) 
{
	arbre *tree1,*tree2,*tree3;
	int numberNodes=0;
	tree1=creerArbre(0,NULL,NULL);
	tree2=creerArbre(13,NULL,NULL);
	tree3=creerArbre(15,tree1,tree2);
	afficheInfexe(tree3);
	printf("\n");
	affichePrefixe(tree3);
	printf("\n");
	affichePostefixe(tree3);
	return 0;
}
