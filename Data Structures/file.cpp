#include <stdio.h>
#include <stdlib.h>
typedef struct cellule{
int val;
struct cellule*suivant;
}cellule;
typedef struct file{
    cellule*tete;
    cellule*queu;
}file;

file vide(){
    file f ;
    f.queu=NULL;
    f.tete=NULL;
    return f;
}
int est_vide(file f){
    if(f.queu==NULL && f.tete==NULL)
        return 1;
    return 0;

}
file emfiler(file f,int val){
    cellule *ptr =(cellule*)malloc(sizeof(cellule));
    ptr->val=val;
    ptr->suivant=NULL;
    if(est_vide(f)==1){
            f.queu =ptr;
             f.tete=ptr;
            return f;
    }
    f.queu->suivant=ptr;
    f.queu=ptr;

return f;
}
file defiler(file f){
    if(est_vide(f)==1)
        exit(-1);
    f.tete=f.tete->suivant;
    if(f.tete==NULL)
    f.queu=NULL;

return f;
}
int tete(file f){
    if(est_vide(f)==1)
        exit(-1);
    return f.tete->val;

}
int max(file ptr){

    int max = tete(ptr);
    while(est_vide(ptr)!=1){

        if(max<tete(ptr))
           max=tete(ptr);
    }
    ptr=defiler(ptr);
    return max;
}
int min (file ptr){

int min = tete(ptr);
ptr=defiler(ptr);
while (est_vide(ptr)!=1){

    if(min>tete(ptr)){
        min = tete(ptr);

    }
    ptr=defiler(ptr);

}

return min;
}
float moyent(file f){

    int c = 0;
    int some =0;
    while(est_vide(f)){
        c++;
        some+=tete(f);
        f=defiler(f);
    }
    return some/c;



}




int main()
{
    file f=vide();
    f=emfiler(f,5);
    f=emfiler(f,2);
    f=emfiler(f,3);
    f=emfiler(f,4);
    while(est_vide(f)!=1){
        printf("%d===>",tete(f));
        f=defiler(f);
    }
    printf("\n");
    printf("%d",min(f));









    return 0;
}
