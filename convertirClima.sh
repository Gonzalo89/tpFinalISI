dir=$PWD

echo -n "" > resultadoFinal

for file in $dir/clima/[!~]*
 do
   nombreArchivo=`echo -n "$file" | sed 's-/.*/--'`
   echo "$nombreArchivo"
   archivoParcial=`echo -n "$dir/ResultadoParcial/$nombreArchivo"`
   echo -n "" > $archivoParcial
   sed 's/ * /;/g' $file > $archivoParcial
   sed -i 's/\*//g' $archivoParcial
   sed -i 's-;\([0-9]\{4\}\)\([0-1][0-9]\)\([0-3][0-9]\);-;\1;\2;\3;-' $archivoParcial
   sed -i 's-;\([0-1]\)\([0-1]\)\([0-1]\)\([0-1]\)\([0-1]\)\([0-1]\)$-;\1;\2;\3;\4;\5;\6-' $archivoParcial
   sed -i 's/[A-Z]//g' $archivoParcial
   sed -i "s-^\([0-9]\)-$nombreArchivo;\1-" $archivoParcial
 done

for file in $dir/ResultadoParcial/*
 do
   cat $file >> resultadoFinal		
 done
