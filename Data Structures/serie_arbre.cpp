#include <stdio.h>
#include <stdlib.h>

typedef struct noeud Noeud;

struct noeud {
	int value;
	Noeud *left;
	Noeud *right;
};
typedef Noeud* Tree;

Tree createTree(Tree left,Tree right,int value)
{
	Tree tree=(Tree)malloc(sizeof(Noeud));
	tree->left=left;
	tree->right=right;
	tree->value=value;
	return tree;
}
void distroy(Tree tree)
{
	if(tree==NULL)
	return;
	distroy(tree->left);
	distroy(tree->right);
	free(tree);
}
int numberNode(Tree tree)
{
	if(tree==NULL) return 0;
	return 1+numberNode(tree->left)+numberNode(tree->right);
}
void infexe(Tree tree)
{
	if(tree==NULL) return;
	printf("{");
	infexe(tree->left);
	printf("%d",tree->value);
	infexe(tree->right);
	printf("}");
}
void prefexe(Tree tree)
{
	if(tree==NULL) return;
	printf("{%d",tree->value);
	prefexe(tree->left);
	prefexe(tree->right);
	printf("}");
}
void postfexe(Tree tree)
{
	if(tree==NULL) return;
	printf("{");
	prefexe(tree->left);
	prefexe(tree->right);
	printf("%d}",tree->value);
}
int isDefferent(Tree tree1,Tree tree2)
{
	if(tree1==NULL) return tree2!=NULL;
	else
	{
		if(tree2==NULL) return 1;
		return tree1->value!=tree2->value || isDefferent(tree1->left,tree2->left) || isDefferent(tree1->right,tree2->right);
	}
}
int estVide(Tree tree)
{
	if(tree==NULL) return 1;
	return 0;
}

Tree trouver(Tree tree,int value)
{
	if(tree==NULL) return NULL;
	else
	{
		if(value<tree->value)
		{
			return trouver(tree->left,value);
		}
		else if(value>tree->value)
		{
			return trouver(tree->right,value);
		}else
		{
			return tree;
		}
	}
}
int isTBR(Tree tree)
{
	if(tree==NULL) return 1;
	else if(tree->left==NULL && tree->right==NULL) return 1;
	else
	{
		return tree->value < tree->right->value && tree->value > tree->left->value && isTBR(tree->left) && isTBR(tree->right);
	}
}

int main() 
{
	Tree tree2 =createTree(NULL,NULL,6);
	Tree tree1 =createTree(NULL,NULL,4);
	Tree tree3 =createTree(NULL,NULL,3);
	Tree tree =createTree(tree1,tree2,5);
	Tree treee =createTree(tree1,tree3,5);
	printf("%d",isTBR(tree));
//	infexe(tree);
//	printf("\n");
//	prefexe(tree);
//	printf("\n");
//	postfexe(tree);
//	printf("\n%d",isDefferent(treee,tree));
	//Tree tree3=trouver(tree,0);
	//printf("\n\n%d",estVide(tree3));
	return 0;
}
