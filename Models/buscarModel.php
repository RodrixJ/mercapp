<?php

class buscarModel extends Model
{

    public function buscarDefuncion($busqueda)
    {
        $parametro=$busqueda.'%';
        return $this->_db->query("select * from ubicacion_descanso inner join defunciones on defuncion_id_defuncion=id_defuncion 
inner join galeria on galeria.defuncion_id_defuncion=id_defuncion where defunciones.primer_nombre like '$parametro'")->fetchAll();
    }

 
    public function datosPerfil($id){
        return $this->_db->query("select * from ubicacion_descanso inner join 
        defunciones on defuncion_id_defuncion=id_defuncion inner join galeria on galeria.defuncion_id_defuncion=id_defuncion inner join municipio on defunciones.municipio=id_municipio
        inner join cementerio on ubicacion_descanso.cementerio_id_cementerio=cementerio.id_cementerio
        where id_defuncion='$id';")->fetchAll();

    }
  


}
