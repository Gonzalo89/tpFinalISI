dir=$PWD
. ./estaciones_provincia.sh
echo -n "" > resultadoFinal

for file in $dir/clima/[!~]*
 do
   nombreArchivo=`echo -n "$file" | sed 's-/.*/--'`
   echo "$nombreArchivo"
   archivoParcial=`echo -n "$dir/ResultadoParcial/$nombreArchivo"`
   echo -n "" > $archivoParcial
   sed 's/ * /;/g' $file > $archivoParcial # reemplaza espacios por ; 
   sed -i 's/\*//g' $archivoParcial # borra *
   sed -i 's-;\([0-1]\)\([0-1]\)\([0-1]\)\([0-1]\)\([0-1]\)\([0-1]\)$-;\1;\2;\3;\4;\5;\6-' $archivoParcial # separa campos binarios
   sed -i 's/[A-Z]//g' $archivoParcial # borra letras
   sed -i "s-^-$nombreArchivo;${!nombreArchivo};-" $archivoParcial # agrega como primer fila el nombre del archivo y el de la provincia
 done

for file in $dir/ResultadoParcial/*
 do
   cat $file >> resultadoFinal		
 done
