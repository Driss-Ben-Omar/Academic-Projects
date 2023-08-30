int minimal(Noued tmp)
{
	if(tmp==NULL) return;

	if(tmp->left!=NULL) return minimal(tmp->left);
	else return tmp->valeur;
}