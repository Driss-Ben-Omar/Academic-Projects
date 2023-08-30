#include <stdio.h>
#include <stdlib.h>
typedef int element;
typedef struct cellule{
    element valeur;
    struct cellule* suivant;
}cellule;
typedef cellule* liste;
liste liste_vide(){
    liste l = (liste*)malloc(sizeof(liste));
    l = NULL;
    return l;
}
int longeur(liste l){
int i=0;
while(l!=NULL){
    i++;
    l=l->suivant;
}
return i;
}
liste inserer_fin(liste l,element e){
liste tmp = (liste*)malloc(sizeof(liste));
liste a = l;
tmp->valeur=e;
tmp->suivant=NULL;
if(l==NULL)
    return tmp;
while(a->suivant!=NULL){
        a = a->suivant;

}
a->suivant=tmp;

return l;
}
liste insere_debut(liste l,element e){
liste tmp = (liste*)malloc(sizeof(liste));
tmp->valeur=e;
tmp->suivant=l;
l=tmp;
return l;

}
liste insere_ind(liste l,int i,element e){
    if(longeur(l)< i)
        return 0;
    else if (longeur(l)==i)
        inserer_fin(l,e);
    else{
        liste tmp = (liste*)malloc(sizeof(liste));
         liste a = l;
         int parc=0;
         while(parc<i){
                a=a->suivant;
                parc++;

         }
         tmp->valeur=e;
         tmp->suivant=a->suivant;
         a=tmp;
    }
         return l;

         }


liste supprimer (liste l,int i){
    liste tmp = l;
    liste ptr;
    int cmp=0;
    while(cmp<i){
        tmp=tmp->suivant;
        cmp++;
    }
    ptr=tmp->suivant;
    tmp->suivant=tmp->suivant->suivant;
    free(ptr);

  return l;
}
element keme(liste l,int k){
    if (longeur(l)<k)
        exit(-1);
    int tmp=0;
    liste a = l;
    while(tmp<k){
            a=a->suivant;
            tmp++;

    }
   return a->valeur;
}







int main()
{
    printf("Hello world!\n");
    return 0;
}