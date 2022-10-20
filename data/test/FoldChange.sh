# ./FoldChange.sh 
#!/bin/bash
	echo "Calculating Fold Change of " ${2//_experssion_average.txt/} " with respect to " ${1//_experssion_average.txt/} " using formular of (Y-X)/X "
        cut -f 1,2 $1 > head_gene
        cut -f 3 $1 > fileX
        cut -f 3 $2 > fileY
        paste fileX fileY > file   # only the two expression columns
        # caluculate fold change
	awk -F '\t' 'BEGIN{fold=0;}{
                if($1!=0){fold=($2-$1)/$1;print fold}
                else{print "Infinity"}
                }' file > foldchanges
        paste gene_names foldchanges > FoldChanges.txt
        echo -e "Gene_ID\tGene_Name\tFold_Change" > ${1//_experssion_average.txt/}_to_${2//_experssion_average.txt/}.FoldChange.txt
        # fold-change sorted in decresing order
        sort -t$'\t' -k3,3nr FoldChanges.txt >> ${1//_experssion_average.txt/}_to_${2//_experssion_average.txt/}.FoldChange.txt
	echo "The result is in " ${1//_experssion_average.txt/}_to_${2//_experssion_average.txt/}.FoldChange.txt
